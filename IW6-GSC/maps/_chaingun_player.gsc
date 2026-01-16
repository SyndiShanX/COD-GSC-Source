/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_chaingun_player.gsc
*****************************************************/

init_chaingun_player() {
  common_scripts\utility::flag_init("player_mounting_chaingun_turret");
  common_scripts\utility::flag_init("player_dismounting_chaingun_turret");
  common_scripts\utility::flag_init("player_on_chaingun_turret");
  chaingun_player_anims();
}

#using_animtree("vehicles");

chaingun_player_anims() {
  level.scr_animtree["turret_player_rig"] = #animtree;
  level.scr_model["turret_player_rig"] = level.chaingun_viewmodel;
  level.scr_anim["turret_player_rig"]["chaingun_hands_geton"] = % chaingun_geton_player;
  level.scr_anim["chaingun_player"]["chaingun_hands_getoff"] = % chaingun_getoff_player;
  level.scr_anim["chaingun_player"]["chaingun_hands_idle"] = % chaingun_idle_player;
  level.scr_anim["chaingun_player"]["chaingun_hands_fire"] = % chaingun_fire_player;
  level.scr_anim["chaingun_player"]["chaingun_hands_idle2fire"] = % chaingun_fire_in_player;
  level.scr_anim["chaingun_player"]["chaingun_hands_idle2fire"] = % chaingun_fire_out_player;
  level.scr_animtree["chaingun_player"] = #animtree;
  level.scr_anim["chaingun_player"]["turret_gun_geton"] = % chaingun_geton_gun;
  level.scr_anim["chaingun_player"]["turret_gun_getoff"] = % chaingun_getoff_gun;
  level.scr_anim["chaingun_player"]["turret_gun_idle"] = % chaingun_idle_gun;
  level.scr_anim["chaingun_player"]["turret_gun_fire"] = % chaingun_fire_gun;
  level.scr_anim["chaingun_player"]["turret_gun_idle2fire"] = % chaingun_fire_in_gun;
  level.scr_anim["chaingun_player"]["turret_gun_fire2idle"] = % chaingun_fire_out_gun;
}

chaingun_turret_init(var_0) {
  level.player endon("death");
  var_1 = self;
  var_1 endon("death");
  var_1 endon("disable_player_turret");
  var_1 makeunusable();
  var_1 setdefaultdroppitch(0);
  var_1.setturretusable = 1;

  while(var_1.setturretusable == 1) {
    wait 1.5;
    var_2 = get_world_relative_offset(var_1.origin, var_1.angles, (-32, 0, -48));
    var_1.usable_turret_trigger = spawn("trigger_radius", var_2, 0, 30, 128);
    var_1 custom_mount_hint_return_when_mounted(var_1.usable_turret_trigger);
    thread player_use_chaingun_with_viewmodel(self, level.player, var_0);
    var_1.usable_turret_trigger delete();
    self waittill("geton_anim_finished");
    var_1 custom_dismount_hint_return_when_dismounted();
    var_1 handle_dismount();
  }
}

custom_mount_hint_return_when_mounted(var_0) {
  level.player endon("death");
  var_0 endon("death");
  self.mount_hint = maps\_hud_util::createfontstring("default", 1.5);
  self.mount_hint.alpha = 0.9;
  self.mount_hint.x = 0;
  self.mount_hint.y = 50;
  self.mount_hint.alignx = "center";
  self.mount_hint.aligny = "middle";
  self.mount_hint.horzalign = "center";
  self.mount_hint.vertalign = "middle";
  self.mount_hint.foreground = 0;
  self.mount_hint.hidewhendead = 1;
  self.mount_hint.hidewheninmenu = 1;
  var_1 = cos(80);

  for(;;) {
    wait 0.05;

    if(level.player istouching(var_0)) {
      if(level.player getstance() == "prone") {
        self.mount_hint settext("");
        continue;
      }

      if(level.player issprintsliding()) {
        self.mount_hint settext("");
        continue;
      }

      if(!maps\_utility::within_fov_2d(level.player getEye(), level.player.angles, self.origin, var_1)) {
        self.mount_hint settext("");
        continue;
      }

      self.mount_hint settext(&"PLATFORM_HOLD_TO_USE");

      if(level.player usebuttonpressed()) {
        self.mount_hint destroy();
        return;
      }
    } else
      self.mount_hint settext("");
  }
}

custom_dismount_hint_return_when_dismounted() {
  level.player endon("death");
  self.disomount_hint = maps\_hud_util::createfontstring("default", 1.5);
  self.disomount_hint.alpha = 0.9;
  self.disomount_hint.x = 0;
  self.disomount_hint.y = 50;
  self.disomount_hint.alignx = "center";
  self.disomount_hint.aligny = "middle";
  self.disomount_hint.horzalign = "center";
  self.disomount_hint.vertalign = "middle";
  self.disomount_hint.foreground = 0;
  self.disomount_hint.hidewhendead = 1;
  self.disomount_hint.hidewheninmenu = 1;
  self.disomount_hint settext(&"PLATFORM_PRESS_TO_DROP");
  notifyoncommand("turret_dismount", "+usereload");
  notifyoncommand("turret_dismount", "+activate");
  level.player waittill("turret_dismount");
  self.disomount_hint destroy();
}

handle_dismount() {
  if(!common_scripts\utility::flag("player_dismounting_chaingun_turret")) {
    common_scripts\utility::flag_set("player_dismounting_chaingun_turret");
    level.player freezecontrols(1);
    self.animname = "chaingun_player";
    self notify("player_dismount");
    maps\_anim::setanimtree();
    var_0 = self gettagangles("tag_ground");
    var_1 = getanimlength( % chaingun_getoff_gun);
    var_2 = maps\_utility::getanim("chaingun_hands_getoff");
    var_3 = maps\_utility::getanim("turret_gun_getoff");
    self clearanim( % root, 0);
    self setanim(var_2, 1, 0, 1);
    self setanim(var_3, 1, 0, 1);
    wait(var_1);
    self detachall();
    self makeusable();
    self setturretdismountorg(self gettagorigin("tag_ground"));
    level.player enableturretdismount();
    self useby(level.player);
    self makeunusable();
    var_4 = 0.15;
    level.player lerpfov(65, var_4);
    var_5 = spawn("script_origin", (0, 0, 0));
    var_5.origin = self gettagorigin("tag_ground");
    var_5.angles = var_0;
    level.player playerlinkto(var_5, "", 1, 0, 0, 0, 0, 0);
    var_5 moveto(self.mount_pos, var_4, var_4 * 0.25);
    wait(var_4 + 0.1);
    var_5 delete();

    if(isDefined(self.disomount_hint))
      self.disomount_hint destroy();

    if(isDefined(self.mount_hint))
      self.mount_hint destroy();

    if(isDefined(self.player_rig))
      self.player_rig delete();

    level.player enableweapons();
    level.player freezecontrols(0);
    setsaveddvar("ammoCounterHide", 0);
    common_scripts\utility::flag_clear("player_on_chaingun_turret");
    common_scripts\utility::flag_clear("player_dismounting_chaingun_turret");
  }
}

player_use_chaingun_with_viewmodel(var_0, var_1, var_2) {
  level.player endon("death");
  common_scripts\utility::flag_set("player_on_chaingun_turret");
  common_scripts\utility::flag_set("player_mounting_chaingun_turret");
  var_0 endon("player_dismount");
  var_0.animname = "chaingun_player";
  var_0 maps\_anim::setanimtree();
  var_1 freezecontrols(1);
  var_1 disableweapons();
  setsaveddvar("ammoCounterHide", 1);
  level.player setstance("stand");
  self.mount_pos = var_1.origin;
  var_0.player_rig = maps\_utility::spawn_anim_model("turret_player_rig");
  var_0.player_rig.animname = "turret_player_rig";
  var_0.player_rig linkto(var_0, "tag_ground", (0, 0, 0), (0, 0, 0));
  var_0.player_rig hide();
  var_0.player_rig common_scripts\utility::delaycall(0.25, ::show);
  var_0 maps\_anim::anim_first_frame_solo(var_0.player_rig, "chaingun_hands_geton", "tag_player");
  maps\_anim::anim_first_frame_solo(var_0, "turret_gun_geton");
  var_1 playerlinktoblend(var_0.player_rig, "tag_origin", 0.3, 0.1, 0.1);
  wait 0.2;
  var_3 = getanimlength( % chaingun_geton_gun);
  var_4 = var_0.player_rig maps\_utility::getanim("chaingun_hands_geton");
  var_5 = maps\_utility::getanim("turret_gun_geton");
  var_0 clearanim( % root, 0);
  var_0 setanim(var_5, 1, 0, 1);
  thread notifyaftertime("geton_anim_finished", "time is up", var_3);
  wait 0.1;
  var_0.player_rig setanim(var_4, 1, 0, 1);
  var_6 = var_0 getanimtime(var_5);
  var_0.player_rig setanimtime(var_4, var_6);
  var_1 lerpfov(65, 0.2);
  self waittill("geton_anim_finished");
  common_scripts\utility::flag_clear("player_mounting_chaingun_turret");

  if(isDefined(var_2) && var_2 == 1)
    thread chaingun_shells(level.chaingun_shelleject_fx, "player_dismounting_chaingun_turret");

  var_1 playerlinktodelta(self, "tag_player", 0.35, 90, 90, 45, 30, 1);
  var_0.player_rig delete();
  var_0.viewhands = level.scr_model["turret_player_rig"];
  var_0 attach(var_0.viewhands, "tag_ground");
  thread cleanup_on_death();
  var_0.is_occupied = 1;
  var_0 makeusable();
  var_0 setmode("manual");
  var_1 unlink();
  var_0 useby(var_1);
  var_0 makeunusable();
  var_1 disableturretdismount();
  var_7 = maps\_utility::getanim("chaingun_hands_idle");
  var_0 clearanim(var_4, 0.1);
  var_0 setanim(var_7, 1, 0.1, 1);
  var_0.hands_animation = var_7;
  var_8 = var_0 maps\_utility::getanim("turret_gun_idle");
  var_0 clearanim(var_5, 0.1);
  var_0 setanim(var_8, 1, 0.1, 1);
  var_0.gun_animation = var_8;
  var_9 = 0;
  var_10 = 0;

  while(common_scripts\utility::flag("player_on_chaingun_turret")) {
    var_9 = level.player attackbuttonpressed();

    if(var_10 != var_9) {
      if(var_9)
        var_0 thread animate_turret_with_viewmodel("chaingun_hands_idle2fire", "chaingun_hands_fire", "turret_gun_idle2fire", "turret_gun_fire");
      else
        var_0 thread animate_turret_with_viewmodel("chaingun_hands_idle2fire", "chaingun_hands_idle", "turret_gun_fire2idle", "turret_gun_idle");

      var_10 = var_9;
    }

    wait 0.05;
  }
}

animate_turret_with_viewmodel(var_0, var_1, var_2, var_3) {
  self notify("turret_anim_change");
  self endon("turret_anim_change");
  self endon("player_dismount");
  var_4 = maps\_utility::getanim(var_0);
  var_5 = maps\_utility::getanim(var_1);
  var_6 = maps\_utility::getanim(var_2);
  var_7 = maps\_utility::getanim(var_3);
  self clearanim(self.hands_animation, 0);
  self.hands_animation = var_4;
  self clearanim(self.gun_animation, 0);
  self.gun_animation = var_6;
  self setanim(var_6, 1, 0.1, 1);
  self setflaggedanim(var_0, var_4, 1, 0.1, 1);
  self waittillmatch(var_0, "end");
  self clearanim(var_4, 0);
  self clearanim(var_6, 0);
  self.hands_animation = var_5;
  self.gun_animation = var_7;
  self setanim(var_5, 1, 0.1, 1);
  self setanim(var_7, 1, 0.1, 1);
}

cleanup_on_death() {
  level.player endon("death");
  level.player waittill("death");
  level.player unlink();
  level.player lerpfov(65, 0.1);
}

chaingun_shells(var_0, var_1) {
  self endon("death");

  if(isDefined(var_1))
    level endon(var_1);

  var_2 = common_scripts\utility::getfx(var_0);
  var_3 = "tag_brass";
  var_4 = 0.1;
  common_scripts\utility::flag_wait("player_on_chaingun_turret");

  while(common_scripts\utility::flag("player_on_chaingun_turret")) {
    while(level.player attackbuttonpressed()) {
      playFXOnTag(var_2, self, var_3);
      wait(var_4);
    }

    wait 0.05;
  }
}

chaingun_turret_disable(var_0) {
  if(common_scripts\utility::flag("player_mounting_chaingun_turret")) {
    common_scripts\utility::flag_waitopen("player_mounting_chaingun_turret");
    wait 0.1;
  }

  if(common_scripts\utility::flag("player_on_chaingun_turret")) {
    self notify("turret_dismount");
    var_0.setturretusable = 0;
  } else
    var_0 notify("disable_player_turret");

  if(isDefined(var_0.usable_turret_trigger))
    var_0.usable_turret_trigger delete();

  if(isDefined(var_0.mount_hint))
    var_0.mount_hint destroy();
}

notifyaftertime(var_0, var_1, var_2) {
  self endon("death");
  self endon(var_1);
  wait(var_2);
  self notify(var_0);
}

get_world_relative_offset(var_0, var_1, var_2) {
  var_3 = cos(var_1[1]);
  var_4 = sin(var_1[1]);
  var_5 = var_2[0] * var_3 - var_2[1] * var_4;
  var_6 = var_2[0] * var_4 + var_2[1] * var_3;
  var_5 = var_5 + var_0[0];
  var_6 = var_6 + var_0[1];
  return (var_5, var_6, var_0[2] + var_2[2]);
}