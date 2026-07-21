/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: vehicle\apache.gsc
***********************************************/

#using_animtree("vehicles");

main(var_0, var_1, var_2) {
  precachemodel("pilot_viewmodel_arms");
  scripts\common\vehicle_build::build_template("apache", var_0, var_1, var_2);
  scripts\common\vehicle_build::build_localinit(::init_local);
  scripts\common\vehicle_build::build_deathmodel(var_0);
  scripts\common\vehicle_build::build_treadfx();
  scripts\common\vehicle_build::build_treadfx(var_2, "default", "vfx/code/tread/heli_dust_default.vfx", 1);
  scripts\common\vehicle_build::build_life(3000, 2800, 3100);
  scripts\common\vehicle_build::build_team("allies");
  scripts\common\vehicle_build::build_aianims(::setanims, ::set_vehicle_anims);
  scripts\common\vehicle_build::build_mainturret("apache_turret", "tag_turret", "veh8_mil_air_ahotel64_turret_wm", "auto_nonai", 0, 0);
  var_3 = randomfloatrange(0, 1);
  scripts\common\vehicle_build::build_light(var_2, "wingtip_green", "tag_light_L_wing", "vfx/core/vehicles/aircraft_light_wingtip_red_lit", "running", var_3);
  scripts\common\vehicle_build::build_light(var_2, "wingtip_red", "tag_light_R_wing", "vfx/core/vehicles/aircraft_light_wingtip_green_lit", "running", var_3);
  scripts\common\vehicle_build::build_light(var_2, "spot", "tag_headlight", "vfx/misc/aircraft_light_hindspot", "spot", 0.0);
  scripts\common\vehicle_build::build_unload_groups(::unload_groups);
  scripts\common\vehicle_build::build_bulletshield(1);
  scripts\common\vehicle_build::build_is_helicopter();

  if(scripts\common\utility::issp())
    scripts\common\vehicle_build::build_drive(%mi28_rotors, undefined, 0, 3.0);
  else
    scripts\common\vehicle_build::build_drive(%bh_rotors, undefined, 0, 3.0);
}

setup_lights(var_0) {}

init_local() {
  self.unload_hover_offset = 922;
  self.script_badplace = 0;
  scripts\common\vehicle::vehicle_lights_on("running");
  self.vehicleanimalias = "blima";
  thread handle_scriptable_vfx();
}

handle_scriptable_vfx() {
  self endon("death");
  scripts\engine\utility::flag_wait("scriptables_ready");
  self setscriptablepartstate("engine", "on");
}

#using_animtree("generic_human");

setanims() {
  var_0 = [];

  for(var_1 = 0; var_1 < 1; var_1++)
    var_0[var_1] = spawnStruct();

  var_0[0].idle = % vh_blima_rappel_pilot;
  var_0[0].sittag = "tag_pilot";
  return var_0;
}

#using_animtree("vehicles");

set_vehicle_anims(var_0) {
  for(var_1 = 0; var_1 < var_0.size; var_1++)
    var_0[var_1].vehicle_getoutanim = % vh_blima_rappel_heli_drop;

  return var_0;
}

unload_groups() {
  var_0 = [];
  var_0["left"] = [];
  var_0["right"] = [];
  var_0["both"] = [];
  var_0["left"][var_0["left"].size] = 3;
  var_0["left"][var_0["left"].size] = 6;
  var_0["left"][var_0["left"].size] = 8;
  var_0["left"][var_0["left"].size] = 9;
  var_0["right"][var_0["right"].size] = 2;
  var_0["right"][var_0["right"].size] = 4;
  var_0["right"][var_0["right"].size] = 5;
  var_0["right"][var_0["right"].size] = 7;
  var_0["both"][var_0["both"].size] = 2;
  var_0["both"][var_0["both"].size] = 3;
  var_0["both"][var_0["both"].size] = 4;
  var_0["both"][var_0["both"].size] = 5;
  var_0["both"][var_0["both"].size] = 6;
  var_0["both"][var_0["both"].size] = 7;
  var_0["both"][var_0["both"].size] = 8;
  var_0["both"][var_0["both"].size] = 9;
  var_0["default"] = var_0["both"];
  return var_0;
}

pilot_apache(var_0, var_1, var_2, var_3) {
  var_0 setclientomnvar("ui_apache_screens_state", 1);
  var_0.ignoreme = 1;
  var_0.pre_apache_angles = var_0 getplayerangles();
  var_0.pre_apache_origin = var_0.origin;
  var_0 scripts\common\utility::allow_fire(0);
  var_0 scripts\common\utility::allow_melee(0);
  var_0 scripts\common\utility::allow_mantle(0);
  var_0 scripts\common\utility::allow_weapon_switch(0);
  var_0 scripts\common\utility::allow_usability(0);
  var_0 disableweapons();
  var_4 = anglesToForward(self.angles) * -500 + anglestoright(self.angles) * 150 + anglestoup(self.angles) * -100;
  var_5 = self.origin + var_4;
  var_0.playersfx = spawn("script_origin", var_5);
  var_0.playersfx linkTo(self);
  var_0.playersfx playLoopSound("apache_amb");
  self setmaxpitchroll(5, 15);
  self.pilot = spawn("script_model", self gettagorigin("tag_origin"));
  self.pilot setModel("pilot_viewmodel_arms");
  self.pilot.angles = self.angles;
  self.pilot linkTo(self, "tag_origin");
  self.pilot.animname = "ks_apache_pilot";
  self.pilot scripts\common\anim::setanimtree();
  var_0 pilot_apache_camera_transition(self, var_1);
  level.player setOrigin(level.incomingapache.origin + (0, 0, -700));
  self sethoverparams(15, 5, 2.5);
  self setturningability(1);
  self setyawspeed(500, 100, 25, 0.5);
  self setotherent(var_0);
  self setCanDamage(1);
  self vehicle_cleardrivingstate();
  self vehicle_setspeedimmediate(2, 200, 200);
  self vehicle_teleport(var_2.origin, var_2.angles);
  scripts\common\vehicle::godon();
  self.mainturret.owner = var_0;
  self.mainturret.team = var_0.team;
  self.mainturret setturretmodechangewait(0);
  self.mainturret setmode("manual");
  self.mainturret setentityowner(var_0);
  self.mainturret setotherent(var_0);
  self.mainturret setdefaultdroppitch(0);
  var_0 scripts\common\utility::allow_fire(1);
  self.num_missiles = 8;
  thread apache_damage_watcher();
  var_0 setclientomnvar("ui_apache_controls", 1);
  var_0 setclientomnvar("ui_apache_missiles_left", self.num_missiles);
  var_0.playersfx unlink();
  var_0.playersfx.origin = self.mainturret.origin;
  var_0.playersfx linkTo(self.mainturret);
  var_0 remotecontrolturret(self.mainturret);
  var_0 remotecontrolvehicle(self);
  var_0 thread pilot_apache_camera_shake(self);
  thread pilot_apache_handle_thermal_switch(var_0, var_3);
  thread pilot_apache_handle_missile_fire(var_0);
}

apache_damage_watcher() {
  self.damage_counter = 1;

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

    if(scripts\engine\utility::is_equal(var_9, getcompleteweaponname("iw8_la_rpapa7_straight_slower"))) {
      radiusdamage(level.player.origin, 100, 50, 20, var_1, "MOD_EXPLOSIVE");
      thread apache_damage_vision(self.damage_counter);
      screenshake(level.player.origin, 4.0, 2.8, 2.9, 3);
      playrumbleonposition("damage_heavy", level.incomingapache.origin);
      wait 0.25;
      playrumbleonposition("damage_heavy", level.incomingapache.origin);
      self.damage_counter++;

      if(self.damage_counter >= 6)
        level notify("apache_dead");

      wait 1;
    }
  }
}

apache_damage_vision(var_0) {
  var_1 = "";
  visionsetfadetoblack("generic_glitch", 0.0);
  wait(var_0);

  if(isDefined(level.current_visionset))
    var_1 = level.current_visionset;

  visionsetfadetoblack(var_1, 0.25);
}

pilot_apache_datapad_transition() {
  self.pre_apache_weapon = self getcurrentprimaryweapon();
  self giveweapon("ks_remote_device");
  self switchtoweapon("ks_remote_device");
  wait 2.0;
  wait 0.5;
  self takeweapon("ks_remote_device");
}

pilot_apache_camera_transition(var_0, var_1) {
  thread scripts\sp\art::setdoftracerange(8000);
  self.og_origin = self.origin;
  self.og_angles = self.angles;
  level.player.nowhizby = 1;
  var_0.animname = "ks_apache_vehicle_camera";
  var_0 vehicle_teleport(var_1.origin, var_1.angles);
  var_0 setvehgoalpos(var_1.origin + anglesToForward(var_1.angles) * 10000.0, 1);
  var_2 = scripts\engine\utility::spawn_tag_origin(var_0.origin, var_0.angles);
  var_0 linkTo(var_2);
  var_2 rotateby((15, 0, 10), 0.05);
  var_2 moveTo(var_2.origin + anglesToForward(var_2.angles) * 5000, 6);
  level.player cameralinkTo(var_0, "tag_player", 1, 1);
  var_0 thread scripts\common\anim::anim_single_solo(var_0.pilot, "pilot_intro", "body_animate_jnt");
  var_0 thread scripts\common\anim::anim_single_solo(var_0, "vehicle_intro", "body_animate_jnt");
  waitframe();
  var_0.pilot setanimrate(var_0.pilot scripts\engine\utility::getanim("pilot_intro"), 0.25);
  var_0 setanimrate(var_0 scripts\engine\utility::getanim("vehicle_intro"), 0.25);
  wait 1;
  var_2 rotateby((-15, 0, -10), 3);
  wait 3;
  var_0.pilot setanimrate(var_0.pilot scripts\engine\utility::getanim("pilot_intro"), 0.75);
  var_0 setanimrate(var_0 scripts\engine\utility::getanim("vehicle_intro"), 0.75);
  wait 3;
  var_0 unlink();
  wait 0.5;
  var_3 = scripts\sp\hud_util::create_client_overlay("black", 0);
  var_3 fadeovertime(0.5);
  var_3.alpha = 1;
  level notify("apache_transition");
  wait 0.5;
  var_3 fadeovertime(0.25);
  var_3.alpha = 0;
  self cameraunlink();
  self unlink();
  self.og_angles = undefined;
}

pilot_apache_camera_transition_out(var_0) {
  var_0 setvehgoalpos(var_0.origin + anglesToForward(var_0.angles) * 10000.0, 1);
  var_1 = scripts\engine\utility::spawn_tag_origin(var_0.origin, var_0.angles);
  var_0 linkTo(var_1);
  var_1 moveTo(var_1.origin + anglesToForward(var_1.angles) * 5000, 6);
  level.blackoverlay = scripts\sp\hud_util::create_client_overlay("black", 1);
  level.blackoverlay fadeovertime(0.2);
  level.blackoverlay.alpha = 0;
  var_0.animname = "ks_apache_vehicle_camera";
  level.player dontinterpolate();
  level.player modifybasefov(65, 0.5);
  level.player cameralinkTo(var_0, "tag_player", 1, 1);
  var_0 thread scripts\common\anim::anim_single_solo(var_0.pilot, "pilot_outro", "body_animate_jnt");
  var_0 thread scripts\common\anim::anim_single_solo(var_0, "vehicle_outro", "body_animate_jnt");
  level notify("kill_all_ai");
  thread scripts\sp\art::setdoftracerange(undefined);
  wait 3;
  level.blackoverlay = scripts\sp\hud_util::create_client_overlay("black", 0);
  level.blackoverlay fadeovertime(0.2);
  level.blackoverlay.alpha = 1;
  wait 0.3;
  level.player cameraunlink();
  level scripts\engine\sp\utility::dof_disable();
}

pilot_apache_camera_shake(var_0) {
  var_0 endon("death");
  var_0 endon("leaving");
  self endon("death");

  for(;;) {
    self earthquakeforplayer(0.04, 0.1, var_0 gettagorigin("tag_origin"), 2000);
    wait 0.1;
  }
}

pilot_apache_handle_thermal_switch(var_0, var_1) {
  self endon("death");
  self endon("leaving");
  self.thermal = 0;
  level.player notifyonplayercommand("switch_thermal_mode", "+stance");
  var_2 = 0;
  var_3 = ["flir_apache_black_to_white", "flir_1_white_to_black", "flir_2_color_gradient", "flir_3_color_gradient"];
  level.player setclientomnvar("ui_apache_thermal_mode", var_2);

  if(isDefined(var_1) && var_1) {
    visionsetthermal(var_3[var_2]);
    level.player thermalvisionon();
    self.thermal = 1;
    level.player enablephysicaldepthoffieldscripting();
    level.player setphysicaldepthoffield(8.0, 1500.0);
    var_2++;
  }
}

apache_thermalshellshock() {
  self endon("death");
  self endon("thermalOff");
  var_0 = 0.2;

  for(;;) {
    level.player shellshock("apache_thermal", var_0);
    wait(var_0);
  }
}

pilot_apache_handle_missile_fire(var_0) {
  self endon("leaving");
  var_0 notifyonplayercommand("shoot_missile", "+frag");
  var_1["left"] = "tag_gun_l";
  var_1["right"] = "tag_gun_r";
  var_2 = "left";
  thread pilot_apache_missile_reloader();

  for(;;) {
    var_0 waittill("shoot_missile");

    if(self.num_missiles > 0) {
      earthquake(0.25, 0.4, self.mainturret.origin, 150);
      var_0 playRumbleOnEntity("damage_heavy");
      var_3 = var_1[var_2];
      var_4 = self gettagorigin(var_3);
      var_4 = var_4 + anglesToForward(self.angles) * 100;
      var_5 = anglesToForward(self.mainturret gettagangles("tag_flash"));
      var_6 = self.mainturret gettagorigin("tag_flash") + var_5 * 10000.0;
      var_7 = physics_createcontents(["physicscontents_solid", "physicscontents_foliage", "physicscontents_sky"]);
      var_8 = scripts\engine\trace::ray_trace_detail(level.player getEye(), level.player getEye() + anglesToForward(level.player getplayerangles()) * 9999, [self, self.mainturret, var_0], undefined, 1);

      if(var_8.size > 0)
        var_9 = var_8["position"];
      else
        var_9 = var_6;

      if(var_3 == "tag_gun_l")
        level.player playSound("weap_hellfire_fire_plr");
      else
        level.player playSound("weap_hellfire_fire_plr_right");

      magicbullet("apache_proj_sp", var_4, var_9, var_0);
      self.num_missiles--;
      level.player setclientomnvar("ui_apache_missiles_left", self.num_missiles);

      if(var_2 == "left")
        var_2 = "right";
      else
        var_2 = "left";

      wait 0.4;
    }
  }
}

pilot_apache_missile_reloader() {
  self endon("leaving");

  for(;;) {
    if(self.num_missiles > 0) {
      waitframe();
      continue;
    } else {
      level notify("apache_reloading");
      wait 5;
      self.num_missiles = 8;
      level.player setclientomnvar("ui_apache_missiles_left", self.num_missiles);
    }
  }
}

apache_modify_damage(var_0) {}

leave_apache_no_player(var_0) {
  setsaveddvar("SLTMRTTOM", 1);
  var_0 setclientomnvar("ui_apache_controls", 0);

  if(self.thermal) {
    level.player thermalvisionoff();
    self.thermal = 0;
    level.player disablephysicaldepthoffieldscripting();
    self notify("thermalOff");
  }

  self notify("leaving");
  hidecinematicletterboxing(2, 0);
  var_0 remotecontrolvehicleoff();
  var_0 remotecontrolturretoff(self.mainturret);
  var_0 pilot_apache_camera_transition_out(self);
}

bug_out(var_0) {
  self setvehgoalpos(scripts\engine\utility::getStruct(var_0, "targetname").origin);
  wait 4;
  self vehicle_setspeed(50, 2, 2);
}

apache_dof_watcher(var_0) {
  level.player allowads(0);
  var_1 = 1;

  while(!scripts\engine\utility::flag(var_0)) {
    var_2 = level.player scripts\engine\sp\utility::isads();

    if(var_2 && var_1) {
      iprintln("on");
      level scripts\engine\sp\utility::dof_enable(0.572089, 142, 0, 0);
      var_1 = 0;
    }

    if(!var_2 && !var_1) {
      iprintln("off");
      level scripts\engine\sp\utility::dof_disable();
      wait 1;
      level scripts\engine\sp\utility::dof_enable(22.2, 142, 0.1, 0.1);
      var_1 = 1;
      wait 1;
    }

    waitframe();
  }

  level scripts\engine\sp\utility::dof_disable();
  level.player allowads(1);
}