/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\vehicle\apache.gsc
***********************************************/

#using_animtree("");

function main(var0, var1, var2) {
  precachemodel("pilot_viewmodel_arms");
  scripts\common\vehicle_build::build_template("apache", var0, var1, var2);
  scripts\common\vehicle_build::build_localinit(&init_local);
  scripts\common\vehicle_build::build_deathmodel(var0);
  scripts\common\vehicle_build::build_treadfx();
  scripts\common\vehicle_build::build_treadfx(var2, "default", "vfx/code/tread/heli_dust_default.vfx", 1);
  scripts\common\vehicle_build::build_life(3000, 2800, 3100);
  scripts\common\vehicle_build::build_team("allies");
  scripts\common\vehicle_build::build_aianims(&setanims, &set_vehicle_anims);
  scripts\common\vehicle_build::build_mainturret("apache_turret", "tag_turret", "veh8_mil_air_ahotel64_turret_wm", "auto_nonai", 0, 0);
  var3 = randomfloatrange(0, 1);
  scripts\common\vehicle_build::build_light(var2, "wingtip_green", "tag_light_L_wing", "vfx/core/vehicles/aircraft_light_wingtip_red_lit", "running", var3);
  scripts\common\vehicle_build::build_light(var2, "wingtip_red", "tag_light_R_wing", "vfx/core/vehicles/aircraft_light_wingtip_green_lit", "running", var3);
  scripts\common\vehicle_build::build_light(var2, "spot", "tag_headlight", "vfx/misc/aircraft_light_hindspot", "spot", 0);
  scripts\common\vehicle_build::build_unload_groups(&unload_groups);
  scripts\common\vehicle_build::build_bulletshield(1);
  scripts\common\vehicle_build::build_is_helicopter();

  if(scripts\common\utility::issp()) {
    scripts\common\vehicle_build::build_drive(%mi28_rotors, undefined, 0, 3);
    return;
  }

  scripts\common\vehicle_build::build_drive($bh_rotors, undefined, 0, 3);
}

function setup_lights(var0) {}

function init_local() {
  self.unload_hover_offset = 922;
  self.script_badplace = 0;
  scripts\common\vehicle::vehicle_lights_on("running");
  self.vehicleanimalias = "blima";
  thread handle_scriptable_vfx();
}

function handle_scriptable_vfx() {
  self endon("death");
  scripts\engine\utility::flag_wait("scriptables_ready");
  self setscriptablepartstate("engine", "on");
}

#using_animtree("generic_human");

function setanims() {
  var0 = [];

  for(var1 = 0; var1 < 1; var1++) {
    var0 = spawnStruct();
  }

  var0[0].idle = % vh_blima_rappel_pilot;
  var0[0].sittag = "tag_pilot";
  return var0;
}

#using_animtree("vehicles");

function set_vehicle_anims(var0) {
  for(var1 = 0; var1 < var0.size; var1++) {
    var0[var1].vehicle_getoutanim = % vh_blima_rappel_heli_drop;
  }

  return var0;
}

function unload_groups() {
  var0 = [];
  GscBinSkip0(0x2e, "left", []);
}

function pilot_apache(var0, var1, var2, var3) {
  var0 setclientomnvar("ui_apache_screens_state", 1);
  var0.ignoreme = 1;
  var0.pre_apache_angles = var0 getplayerangles();
  var0.pre_apache_origin = var0.origin;
  var0 scripts\common\utility::allow_fire(0);
  var0 scripts\common\utility::allow_melee(0);
  var0 scripts\common\utility::allow_mantle(0);
  var0 scripts\common\utility::allow_weapon_switch(0);
  var0 scripts\common\utility::allow_usability(0);
  var0 disableweapons();
  var4 = anglesToForward(self.angles) * -500 + anglestoright(self.angles) * 150 + anglestoup(self.angles) * -100;
  var5 = self.origin + var4;
  var0.playersfx = spawn("script_origin", var5);
  var0.playersfx linkTo(self);
  var0.playersfx playLoopSound("apache_amb");
  self setmaxpitchroll(5, 15);
  self.pilot = spawn("script_model", self gettagorigin("tag_origin"));
  self.pilot setModel("pilot_viewmodel_arms");
  self.pilot.angles = self.angles;
  self.pilot linkTo(self, "tag_origin");
  self.pilot.animname = "ks_apache_pilot";
  self.pilot scripts\common\anim::setanimtree();
  pilot_apache_camera_transition(var0, self, var1);
  level.player setOrigin(level.incomingapache.origin + (0, 0, -700));
  self sethoverparams(15, 5, 2.5);
  self setturningability(1);
  self setyawspeed(500, 100, 25, 0.5);
  self setotherent(var0);
  self setCanDamage(1);
  self vehicle_cleardrivingstate();
  self vehicle_setspeedimmediate(2, 200, 200);
  self vehicle_teleport(var2.origin, var2.angles);
  scripts\common\vehicle::godon();
  self.mainturret.owner = var0;
  self.mainturret.team = var0.team;
  self.mainturret setturretmodechangewait(0);
  self.mainturret setmode("manual");
  self.mainturret setentityowner(var0);
  self.mainturret setotherent(var0);
  self.mainturret setdefaultdroppitch(0);
  var0 scripts\common\utility::allow_fire(1);
  self.num_missiles = 8;
  thread apache_damage_watcher();
  var0 setclientomnvar("ui_apache_controls", 1);
  var0 setclientomnvar("ui_apache_missiles_left", self.num_missiles);
  var0.playersfx unlink();
  var0.playersfx.origin = self.mainturret.origin;
  var0.playersfx linkTo(self.mainturret);
  var0 remotecontrolturret(self.mainturret);
  var0 remotecontrolvehicle(self);
  thread pilot_apache_camera_shake(var0);
  thread pilot_apache_handle_thermal_switch(var0, var3);
  thread pilot_apache_handle_missile_fire(var0);
}

function apache_damage_watcher() {
  self.damage_counter = 1;

  for(;;) {
    self waittill("damage", var0, var1, var2, var3, var4, var5, var6, var7, var8, var9);

    if(scripts\engine\utility::is_equal(var9, getcompleteweaponname("iw8_la_rpapa7_straight_slower"))) {
      radiusdamage(level.player.origin, 100, 50, 20, var1, "MOD_EXPLOSIVE");
      thread apache_damage_vision(self.damage_counter);
      screenshake(level.player.origin, 4, 2.8, 2.9, 3);
      playrumbleonposition("damage_heavy", level.incomingapache.origin);
      wait 0.25;
      playrumbleonposition("damage_heavy", level.incomingapache.origin);
      self.damage_counter++;

      if(self.damage_counter >= 6) {
        level notify("apache_dead");
      }

      wait 1;
    }
  }
}

function apache_damage_vision(var0) {
  var1 = "";
  visionsetfadetoblack("generic_glitch", 0);
  wait var0;

  if(isDefined(level.current_visionset)) {
    var1 = level.current_visionset;
  }

  visionsetfadetoblack(var1, 0.25);
}

function pilot_apache_datapad_transition() {
  self.pre_apache_weapon = self getcurrentprimaryweapon();
  self giveweapon("ks_remote_device");
  self switchtoweapon("ks_remote_device");
  wait 2;
  wait 0.5;
  self takeweapon("ks_remote_device");
}

function pilot_apache_camera_transition(var0, var1) {
  thread scripts\sp\art::setdoftracerange(8000);
  self.og_origin = self.origin;
  self.og_angles = self.angles;
  level.player.nowhizby = 1;
  var0.animname = "ks_apache_vehicle_camera";
  var0 vehicle_teleport(var1.origin, var1.angles);
  var0 setvehgoalpos(var1.origin + anglesToForward(var1.angles) * 10000, 1);
  var2 = scripts\engine\utility::spawn_tag_origin(var0.origin, var0.angles);
  var0 linkTo(var2);
  var2 rotateby((15, 0, 10), 0.05);
  var2 moveTo(var2.origin + anglesToForward(var2.angles) * 5000, 6);
  level.player cameralinkTo(var0, "tag_player", 1, 1);
  var0 thread scripts\common\anim::anim_single_solo(var0.pilot, "pilot_intro", "body_animate_jnt");
  var0 thread scripts\common\anim::anim_single_solo(var0, "vehicle_intro", "body_animate_jnt");
  waitframe();
  var0.pilot setanimrate(var0.pilot scripts\engine\utility::getanim("pilot_intro"), 0.25);
  var0 setanimrate(var0 scripts\engine\utility::getanim("vehicle_intro"), 0.25);
  wait 1;
  var2 rotateby((-15, 0, -10), 3);
  wait 3;
  var0.pilot setanimrate(var0.pilot scripts\engine\utility::getanim("pilot_intro"), 0.75);
  var0 setanimrate(var0 scripts\engine\utility::getanim("vehicle_intro"), 0.75);
  wait 3;
  var0 unlink();
  wait 0.5;
  var3 = scripts\sp\hud_util::create_client_overlay("black", 0);
  var3 fadeovertime(0.5);
  var3.alpha = 1;
  level notify("apache_transition");
  wait 0.5;
  var3 fadeovertime(0.25);
  var3.alpha = 0;
  self cameraunlink();
  self unlink();
  self.og_angles = undefined;
}

function pilot_apache_camera_transition_out(var0) {
  var0 setvehgoalpos(var0.origin + anglesToForward(var0.angles) * 10000, 1);
  var1 = scripts\engine\utility::spawn_tag_origin(var0.origin, var0.angles);
  var0 linkTo(var1);
  var1 moveTo(var1.origin + anglesToForward(var1.angles) * 5000, 6);
  level.blackoverlay = scripts\sp\hud_util::create_client_overlay("black", 1);
  level.blackoverlay fadeovertime(0.2);
  level.blackoverlay.alpha = 0;
  var0.animname = "ks_apache_vehicle_camera";
  level.player dontinterpolate();
  level.player modifybasefov(65, 0.5);
  level.player cameralinkTo(var0, "tag_player", 1, 1);
  var0 thread scripts\common\anim::anim_single_solo(var0.pilot, "pilot_outro", "body_animate_jnt");
  var0 thread scripts\common\anim::anim_single_solo(var0, "vehicle_outro", "body_animate_jnt");
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

function pilot_apache_camera_shake(var0) {
  var0 endon("death");
  var0 endon("leaving");
  self endon("death");

  for(;;) {
    self earthquakeforplayer(0.04, 0.1, var0 gettagorigin("tag_origin"), 2000);
    wait 0.1;
  }
}

function pilot_apache_handle_thermal_switch(var0, var1) {
  self endon("death");
  self endon("leaving");
  self.thermal = 0;
  level.player notifyonplayercommand("switch_thermal_mode", "+stance");
  var2 = 0;
  var3 = ["flir_apache_black_to_white", "flir_1_white_to_black", "flir_2_color_gradient", "flir_3_color_gradient"];
  level.player setclientomnvar("ui_apache_thermal_mode", var2);

  if(isDefined(var1) && var1) {
    visionsetthermal(var3[var2]);
    level.player thermalvisionon();
    self.thermal = 1;
    level.player enablephysicaldepthoffieldscripting();
    level.player setphysicaldepthoffield(8, 1500);
    var2++;
    return;
  }
}

function apache_thermalshellshock() {
  self endon("death");
  self endon("thermalOff");
  var0 = 0.2;

  for(;;) {
    level.player shellshock("apache_thermal", var0);
    wait var0;
  }
}

function pilot_apache_handle_missile_fire(var0) {
  self endon("leaving");
  var0 notifyonplayercommand("shoot_missile", "+frag");
  GscBinSkip1(0x45, "left", "tag_gun_l");
}

function pilot_apache_missile_reloader() {
  self endon("leaving");

  for(;;) {
    if(self.num_missiles > 0) {
      waitframe();
      continue;
    }

    level notify("apache_reloading");
    wait 5;
    self.num_missiles = 8;
    level.player setclientomnvar("ui_apache_missiles_left", self.num_missiles);
  }
}

function apache_modify_damage(var0) {}

function leave_apache_no_player(var0) {
  setsaveddvar("SLTMRTTOM", 1);
  var0 setclientomnvar("ui_apache_controls", 0);

  if(self.thermal) {
    level.player thermalvisionoff();
    self.thermal = 0;
    level.player disablephysicaldepthoffieldscripting();
    self notify("thermalOff");
  }

  self notify("leaving");
  hidecinematicletterboxing(2, 0);
  var0 remotecontrolvehicleoff();
  var0 remotecontrolturretoff(self.mainturret);
  pilot_apache_camera_transition_out(var0, self);
}

function bug_out(var0) {
  self setvehgoalpos(scripts\engine\utility::getStruct(var0, "targetname").origin);
  wait 4;
  self vehicle_setspeed(50, 2, 2);
}

function apache_dof_watcher(var0) {
  level.player allowads(0);
  var1 = 1;

  while(!scripts\engine\utility::flag(var0)) {
    var2 = level.player scripts\engine\sp\utility::isads();

    if(var2 && var1) {
      iprintln("on");
      level scripts\engine\sp\utility::dof_enable(0.572089, 142, 0, 0);
      var1 = 0;
    }

    if(!var2 && !var1) {
      iprintln("off");
      level scripts\engine\sp\utility::dof_disable();
      wait 1;
      level scripts\engine\sp\utility::dof_enable(22.2, 142, 0.1, 0.1);
      var1 = 1;
      wait 1;
    }

    waitframe();
  }

  level scripts\engine\sp\utility::dof_disable();
  level.player allowads(1);
}