/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3003.gsc
***************************************/

func_D623(var_00) {
  precachemodel(var_00 + "_landed");
  precachemodel("veh_mil_air_ca_drop_pod_doors");
  precachemodel("veh_mil_air_ca_drop_pod_large_static_rail_c6");
  func_75E7();
  func_1F2B();
}

func_75E7() {
  level._effect["drop_pod_thruster"] = loadfx("vfx\iw7\core\vehicle\droppod\veh_drop_pod_thruster.vfx");
  level._effect["drop_pod_trail"] = loadfx("vfx\iw7\core\vehicle\droppod\veh_drop_pod_trail.vfx");
  level._effect["drop_pod_impact"] = loadfx("vfx\iw7\core\vehicle\droppod\veh_drop_pod_impact.vfx");
  level._effect["pod_door_close"] = loadfx("vfx\iw7\core\vehicle\droppod\veh_drop_pod_door_close.vfx");
  level._effect["pod_door_move"] = loadfx("vfx\iw7\core\vehicle\droppod\veh_drop_pod_door_move.vfx");
}

func_1F2B() {
  func_215E();
}

#using_animtree("script_model");

func_215E() {
  level.func_EC87["droppod_arm"] = #animtree;
  level.func_EC8C["droppod_arm"] = "veh_mil_air_ca_drop_pod_arm";
  level.func_EC85["droppod_arm_0"]["pod_exit"] = % vh_red_droppod_exit_arm_01;
  level.func_EC85["droppod_arm_0"]["pod_idle"][0] = % vh_red_droppod_exit_idle_arm_01;
  level.func_EC85["droppod_arm_1"]["pod_exit"] = % vh_red_droppod_exit_arm_02;
  level.func_EC85["droppod_arm_1"]["pod_idle"][0] = % vh_red_droppod_exit_idle_arm_02;
  level.func_EC85["droppod_arm_2"]["pod_exit"] = % vh_red_droppod_exit_arm_03;
  level.func_EC85["droppod_arm_2"]["pod_idle"][0] = % vh_red_droppod_exit_idle_arm_03;
  level.func_EC85["droppod_arm_3"]["pod_exit"] = % vh_red_droppod_exit_arm_04;
  level.func_EC85["droppod_arm_3"]["pod_idle"][0] = % vh_red_droppod_exit_idle_arm_04;
}

func_D629() {
  self endon("death");

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "no_doors_pop") {
    self.func_BFEB = 1;
  }

  self motionblurhqenable();
  scripts\sp\vehicle::playgestureviewmodel();
  thread func_5D49();
  self.func_4D94 = spawnStruct();
  waittillframeend;
  func_FA1E();
  thread func_D60B();
  thread func_5FF0();

  if(isDefined(self.script_animation)) {
    func_1F82();
  }
  else {
    func_BC59();

    if(isDefined(self.script_delay)) {
      self hide();
      scripts\sp\utility::script_delay();
      self show();
    }

    func_D60C();
  }

  self notify("landed");
  self motionblurhqdisable();
  thread func_D614();

  if(isDefined(self.func_ED54)) {
    scripts\engine\utility::waitframe();
    func_514A();
  }

  if(isDefined(self.func_E4FB) && self.func_E4FB.size) {
    thread func_D62B();
  }

  wait 0.05;
  self.func_4D94 = undefined;
}

func_5D49() {
  self endon("entitydeleted");
  self endon("droppod_magic_bullet_shield");
  wait 0.05;

  if(!self.func_E4FB.size) {
    return;
  }
  var_00 = self.func_E4FB;

  foreach(var_02 in var_00) {
  var_02 scripts\sp\utility::func_B14F();
  }

  self waittill("landed");
  var_00 = scripts\sp\utility::func_22B9(var_00);

  foreach(var_02 in var_00) {
  var_02 scripts\sp\utility::func_1101B();
  }
}

func_FA1E() {
  if(issubstr(self.classname, "cheap")) {
    return;
  }
  var_00 = [];

  for(var_01 = 0; var_01 < 4; var_1++) {
    var_0[var_01] = ::scripts\sp\utility::func_10639("droppod_arm");
    var_0[var_01].func_1FBB = "droppod_arm_" + var_01;
  }

  self.func_226D = var_00;
  scripts\sp\anim::func_1EC1(self.func_226D, "pod_exit");

  foreach(var_03 in self.func_226D) {
  var_03 linkto(self);
  }

  self attach("veh_mil_air_ca_drop_pod_large_static_rail_c6", "tag_origin");
}

func_FA1F() {
  playFXOnTag(level._effect["pod_door_close"], self, "TAG_ORIGIN");
}

func_FB98() {
  if(!isDefined(self)) {
    return;
  }
  if(isDefined(self.func_594A)) {
    return;
  }
  var_00 = spawn("script_origin", self.origin);
  var_00 linkto(self);

  if(!isDefined(self.func_4D94.droptime)) {
    self.func_4D94.droptime = 1.41;
  }

  if(self.func_4D94.droptime > 1.4) {
    var_01 = self.func_4D94.droptime - 1.35;
    wait(var_01);
  }

  var_02 = "droppod_incoming";

  if(isDefined(self.func_93D4)) {
    var_02 = self.func_93D4;
  }

  var_00 playSound(var_02);
  scripts\engine\utility::waittill_any("death", "landed");

  if(isDefined(self)) {
    var_03 = "droppod_land_impact";

    if(isDefined(self.func_934A)) {
      var_03 = self.func_934A;
    }

    _playworldsound(var_03, self.origin);
  }

  wait 0.06;

  if(isDefined(var_00)) {
    var_00 stopsounds();
    var_00 delete();
  }

  if(isDefined(self)) {
    self notify("stop sounddroppod_descend_lp");
  }
}

func_5FF0() {
  self endon("entitydeleted");
  self.func_4D94.func_75C6 = ["TAG_THRUSTER_1", "TAG_THRUSTER_2", "TAG_THRUSTER_3", "TAG_THRUSTER_4"];
  self waittill("dropping");
  playFXOnTag(scripts\engine\utility::getfx("drop_pod_trail"), self, "tag_fx");
  thread func_FB98();
  var_00 = "drop_pod_thruster";

  if(isDefined(self.func_1186F)) {
    var_00 = self.func_1186F;
  }

  foreach(var_02 in self.func_4D94.func_75C6) {
  thread scripts\sp\utility::func_75C4(var_00, var_02);
  }

  scripts\engine\utility::waittill_any("landed", "death");

  foreach(var_02 in self.func_4D94.func_75C6) {
  thread scripts\sp\utility::func_75F8(var_00, var_02);
  }
}

func_D60C() {
  self endon("death");
  self.func_4D94.droptime = func_36E8();
  self.func_4D94.func_AD34 = scripts\engine\utility::spawn_tag_origin();
  self.func_4D94.func_AD34.origin = self.origin;
  self.func_4D94.func_AD34.angles = self.angles;
  self linkto(self.func_4D94.func_AD34);
  self notify("dropping");
  self.func_4D94.func_AD34 moveto(self.func_4D94.func_A843, self.func_4D94.droptime, self.func_4D94.droptime * 0.3, 0);
  self.func_4D94.func_AD34 waittill("movedone");
  self.func_4D94.func_AD34 delete();
}

func_D614() {
  if(isDefined(self.func_BFF7)) {
    return;
  }
  var_00 = self.origin + (0, 0, 32);

  if(!isDefined(self.script_damage) || isDefined(self.script_damage) && self.script_damage) {
    radiusdamage(var_00, 128, 500, 250, self, "MOD_EXPLOSIVE");
  }

  physicsexplosionsphere(var_00, 500, 1, 1);
  stopFXOnTag(scripts\engine\utility::getfx("drop_pod_trail"), self, "tag_fx");
  playFX(scripts\engine\utility::getfx("drop_pod_impact"), self.origin);
  earthquake(0.5, 1, self.origin, 2500);
  playrumbleonentity("droppod_impact", self.origin);
  self setModel(self.model + "_landed");
  self disconnectpaths();
}

func_D62B() {
  if(isDefined(self.func_10819)) {
    self waittill(self.func_10819);
  }

  if(isDefined(self.func_226D)) {
    thread scripts\sp\anim::func_1F2C(self.func_226D, "pod_exit");
  }

  thread scripts\sp\vehicle::func_13253();
}

func_D60B(var_00) {
  self attach("veh_mil_air_ca_drop_pod_doors", "tag_origin");

  if(isDefined(self.func_BFEB) && self.func_BFEB) {
    return;
  }
  if(isDefined(var_00)) {
    self waittill("pop_doors");
  }
  else {
    self waittill("dropping");
    scripts\engine\utility::waittill_any_timeout(self.func_4D94.droptime * 0.9, "pop_doors");
  }

  self detach("veh_mil_air_ca_drop_pod_doors", "tag_origin");
  self playSound("droppod_door_open");
  _killfxontag(level._effect["pod_door_close"], self, "TAG_ORIGIN");
  playFXOnTag(level._effect["pod_door_move"], self, "TAG_ORIGIN");
}

func_514A() {
  if(isDefined(self.func_226D)) {
    scripts\sp\utility::func_228A(self.func_226D);
  }

  self delete();
}

func_36E8() {
  if(isDefined(self.speed)) {
    var_00 = self.speed;
  }
  else {
    var_00 = 1000;
  }

  var_01 = var_00 * 5280 / 3600;
  var_02 = self.func_4D94.func_56F3;
  var_03 = var_02 / var_01;
  return var_03;
}

func_1F82() {
  self hide();
  var_00 = self.script_animation;
  self.func_1FBB = "droppod";
  self.func_4D94.droptime = getanimlength(scripts\sp\utility::func_7DC1(var_00));
  var_01 = self;

  if(isDefined(self.func_1FBE)) {
    var_01 = self.func_1FBE;
  }

  thread func_C12A();
  var_01 scripts\sp\anim::func_1EC3(self, var_00);
  self show();
  self notify("dropping");
  var_01 scripts\sp\anim::func_1F35(self, var_00);
}

func_C12A(var_00) {
  wait(self.func_4D94.droptime * 0.8);
  self notify("pop_doors");
}

func_BC59() {
  if(isDefined(self.script_parameters)) {
    self.func_4D94.func_56F3 = int(self.script_parameters);
  }
  else {
    self.func_4D94.func_56F3 = 4000;
  }

  self.func_4D94.func_A843 = self.origin;
  self.func_4D94.func_5EF2 = (0, 0, 1);
  var_00 = self.angles;
  var_01 = scripts\sp\utility::func_7A96();

  if(isDefined(var_01)) {
    if(isDefined(var_1.script_noteworthy) && var_1.script_noteworthy == "drop_angle") {
      self.func_4D94.func_5EF2 = vectornormalize(var_1.origin - self.origin);
      var_00 = vectortoangles(self.func_4D94.func_5EF2) + (90, 0, 0);
    }
  }

  if(isDefined(self.script_anglevehicle) && self.script_anglevehicle) {
    self.func_4D94.func_5EF2 = anglestoup(self.angles);
    var_00 = self.angles;
  }

  var_02 = self.origin + self.func_4D94.func_5EF2 * self.func_4D94.func_56F3;
  self vehicle_teleport(var_02, var_00);
}

func_2477() {
  self.func_4D94.doors = scripts\sp\utility::func_10639("droppod_door");
  scripts\sp\anim::func_1EC3(self.func_4D94.doors, "door_pop");
  self.func_4D94.doors linkto(self);
}