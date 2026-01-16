/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\cornered_zipline_turret.gsc
********************************************/

player_handle_zipline_turret(var_0) {
  wait 1.75;
  level.fake_turret setModel("weapon_zipline_rope_launcher_alt_obj");
  var_1 = getent("zipline_launcher_trigger_player", "targetname");
  var_1 setcursorhint("HINT_NOICON");

  if(!maps\cornered_code::is_e3()) {
    if(level.player common_scripts\utility::is_player_gamepad_enabled())
      var_1 sethintstring(&"CORNERED_DEPLOY_ZIPLINE_TURRET_CONSOLE");
    else
      var_1 sethintstring(&"CORNERED_DEPLOY_ZIPLINE_TURRET");
  }

  var_2 = common_scripts\utility::getstruct("zipline_launcher_lookat", "targetname");
  maps\player_scripted_anim_util::waittill_trigger_activate_looking_at(var_1, var_2, cos(40), 0, 1);
  common_scripts\utility::flag_set("zipline_launcher_setup");
  level.fake_turret setModel("weapon_zipline_rope_launcher_alt");
  thread maps\cornered_audio::aud_zipline("unfold");

  if(isDefined(level.player.binoculars_active) && level.player.binoculars_active) {
    level.player notify("use_binoculars");
    waittillframeend;
  }

  maps\cornered_binoculars::take_binoculars();
  level.player common_scripts\utility::_disableweapon();
  level.player setstance("stand");
  level.player allowcrouch(0);
  level.player allowprone(0);

  if(level.player getstance() == "crouch" || level.player getstance() == "prone")
    wait 1;

  level.zipline_anim_struct maps\_anim::anim_first_frame_solo(level.cornered_player_arms, "cornered_launcher_setup_player");
  level.player playerlinktoblend(level.cornered_player_arms, "tag_player", 0.5);
  wait 0.5;
  level.player playerlinktoabsolute(level.cornered_player_arms, "tag_player");
  maps\cornered_code::show_player_arms();
  thread lerp_fov_to_turret();
  level.zipline_anim_struct thread maps\_anim::anim_single_solo(level.fake_turret, "zipline_launcher_setup_player");
  level.zipline_anim_struct thread maps\_anim::anim_single_solo(level.cornered_player_arms, "cornered_launcher_setup_player");
  wait 2.5;
  common_scripts\utility::flag_set("player_setting_turret");
  level.cornered_player_arms waittillmatch("single anim", "end");
  common_scripts\utility::flag_set("player_on_turret");
  var_0.origin = level.fake_turret.origin;
  var_0.angles = level.fake_turret.angles;
  level.player unlink();
  maps\cornered_code::hide_player_arms();
  thread player_viewhands_zipline_launcher(var_0, "viewhands_player_gs_stealth");
  level.fake_turret hide();
  var_0 show();
  var_0 maketurretoperable();
  var_0 useby(level.player);
  var_0 thread turret_spawn_aim_arrow();
  var_0 thread turret_moving();
  self disableturretdismount();
  var_0 turretfireenable();

  if(!maps\cornered_code::is_e3())
    thread display_zipline_fire_hint();

  level.zipline_anim_struct maps\_anim::anim_first_frame_solo(level.cornered_player_arms, "cornered_zipline_launcher_fire_playerarms");
  var_0 waittill("turret_fire");
  var_0 thread turret_delete_aim_arrow();
  screenshake(level.player.origin, 2, 0, 0, 0.75, 0, -1, 0, 17);
  common_scripts\utility::waitframe();
  var_0 turretfiredisable();
  self enableturretdismount();
  var_0 maketurretinoperable();
  var_0 setturretdismountorg(level.cornered_player_arms gettagorigin("tag_player"));
  var_0 useby(self);
  level.player allowcrouch(1);
  level.player allowprone(1);
  var_0 hide();
  level.fake_turret show();
  thread launch_rope_player(var_0);
  common_scripts\utility::waitframe();
  level.player playerlinktoblend(level.cornered_player_arms, "tag_player", 0.25);
  wait 0.25;
  level.player playerlinktoabsolute(level.cornered_player_arms, "tag_player");
  maps\cornered_code::show_player_arms();
  level.zipline_anim_struct thread maps\_anim::anim_single_solo(level.fake_turret, "zipline_launcher_fire_player");
  level.zipline_anim_struct thread maps\_anim::anim_single_solo(level.cornered_player_arms, "cornered_zipline_launcher_fire_playerarms");
  common_scripts\utility::flag_set("player_fired_zipline");
  wait 1;
  common_scripts\utility::flag_set("obj_fire_zipline");
  level.cornered_player_arms waittillmatch("single anim", "end");
  maps\cornered_code::hide_player_arms();
  level.player unlink();
  level.player common_scripts\utility::_enableweapon();
}

display_zipline_fire_hint() {
  level endon("player_fired_zipline");

  for(;;) {
    wait 7.0;
    level.player thread maps\_utility::display_hint("fire_zipline");
  }
}

turret_moving() {
  var_0 = level.player getplayerangles();

  while(!common_scripts\utility::flag("player_fired_zipline")) {
    var_1 = level.player getplayerangles();

    if(distance(var_0, var_1) > 0.01)
      thread maps\cornered_audio::aud_zipline("aim", distance(var_0, var_1));
    else
      thread maps\cornered_audio::aud_zipline("stop_loop");

    var_0 = var_1;
    common_scripts\utility::waitframe();
  }
}

lerp_fov_to_turret() {
  level.player lerpfov(55, 8);
}

launch_rope_player(var_0) {
  thread maps\cornered_audio::aud_zipline("rope_shot", (-29190, -4758, 27276));
  level.zipline_rope show();
  playFXOnTag(level._effect["zipline_shot"], var_0, "tag_flash");
  playFXOnTag(level._effect["vfx_zipline_tracer"], level.zipline_rope, "J_zip_1");
  thread maps\cornered_code::launch_rope(level.zipline_anim_struct, level.zipline_rope, "cornered_zipline_playerline_launched", "cornered_zipline_playerline_at_rest_loop");
  wait 8;
  common_scripts\utility::flag_set("player_can_use_zipline");
}

#using_animtree("player");

player_viewhands_zipline_launcher(var_0, var_1) {
  level.player endon("missionend");
  var_0 useanimtree(#animtree);
  var_0.animname = "zipline_hands";
  var_0.has_hands = 0;
  var_0 show_hands(var_1);
  var_0 thread handle_mounting(var_1);
  var_0 setanim( % cornered_zipline_aim_idle_playerarms, 1, 0, 1);
}

handle_mounting(var_0) {
  var_1 = self;
  var_1 endon("death");

  for(;;) {
    var_1 waittill("turretownerchange");
    var_2 = var_1 getturretowner();

    if(!isalive(var_2)) {
      hide_hands(var_0);
      continue;
    }

    show_hands(var_0);
  }
}

show_hands(var_0) {
  var_1 = self;

  if(var_1.has_hands) {
    return;
  }
  var_1 dontcastshadows();
  var_1.has_hands = 1;
  var_1 attach(var_0, "TAG_ARMS_ATTACH");
}

hide_hands(var_0) {
  var_1 = self;

  if(!var_1.has_hands) {
    return;
  }
  var_1 castshadows();
  var_1.has_hands = 0;
  var_1 detach(var_0, "TAG_ARMS_ATTACH");
}

turret_spawn_aim_arrow() {
  self.aim_arrow = newclienthudelem(level.player);
  self.aim_arrow.x = 0;
  self.aim_arrow.y = 0;
  self.aim_arrow.alignx = "center";
  self.aim_arrow.aligny = "middle";
  self.aim_arrow.horzalign = "center";
  self.aim_arrow.vertalign = "middle";
  self.aim_arrow setshader("reticle_center_cross", 32, 32);
  self.aim_arrow.alpha = 1;
  self.aim_arrow.sort = -3;
  self.aim_arrow.color = (1, 1, 1);
  self.aim_arrow_on_target = 1;
}

turret_delete_aim_arrow() {
  if(isDefined(self.aim_arrow))
    self.aim_arrow destroy();
}