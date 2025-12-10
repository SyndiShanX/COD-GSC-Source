/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3036.gsc
***************************************/

func_A2A8(var_00, var_01, var_02, var_03) {
  func_490C(var_00, var_01);
  var_04 = scripts\engine\utility::ter_op(isDefined(var_03), "tag_pip_copilot", "tag_pip");
  thread func_19CF(var_04);
  scripts\sp\pip_util::func_CBB5(self, var_04, 42);
  level.func_CB9C.clipdistance = 2500;
  thread func_A2AA();
  setomnvar("ui_pip_message_text_bottom", "script_empty_string");
  setomnvar("ui_pip_message_text_top", "jackal_pip_top");
  setomnvar("ui_pip_message_type", 1);

  if(isDefined(var_02)) {
    wait 0.65;
    var_00 scripts\sp\utility::func_10347(var_02);
  }
}

func_A2AA() {
  level endon("pip_closed");
  self waittill("death");
  setomnvar("ui_pip_static", 1);
  wait 0.5;
  func_A2A9();
  setomnvar("ui_pip_static", 0);
}

func_F435(var_00) {
  level.func_A056.func_A7EA = var_00;
}

func_16FF(var_00) {
  level.func_A056.func_A7E8 = scripts\engine\utility::array_combine(level.func_A056.func_A7E8, var_00);
}

func_F434(var_00) {
  level.func_A056.func_A7E9 = var_00;
}

func_D803(var_00, var_01) {
  if(isDefined(var_00))
    precachemodel(var_00);

  if(!isDefined(var_01))
    var_01 = (0, 0, 0);

  level.func_A056.func_C8F7 = var_00;
  level.func_A056.func_C8F8 = var_01;
}

func_A321(var_00) {
  level.func_90E2.func_1112E = var_00;
}

func_A31E(var_00) {
  level.func_7000 = var_00;
}

func_A2A9(var_00) {
  scripts\sp\pip_util::func_CBA3();

  if(isDefined(self) && isDefined(self.func_CB89) && !isDefined(var_00))
    self.func_CB89 delete();
}

func_490C(var_00, var_01) {
  if(!isDefined(var_00))
    self.func_CB89 = func_1063A();
  else
    self.func_CB89 = var_00;

  thread scripts\engine\utility::delete_on_death(self.func_CB89);
  self.func_CB89 hide();
  var_02 = "tag_player";
  var_03 = "";
  self.func_CB89.origin = self gettagorigin(var_02);
  self.func_CB89 dontinterpolate();
  self.func_CB89 linkto(self, var_02, (0, 0, 0), (0, 0, 0));
  self.func_CB89 give_attacker_kill_rewards(var_03);
  self.func_CB89 show();
}

func_D8FE(var_00) {
  self.func_CB89 endon("death");

  for(;;) {
    iprintln("Pilot dist from linkto tag: " + distance(self.func_CB89.origin, self gettagorigin(var_00)));
    wait 0.05;
  }
}

func_19CF(var_00) {
  scripts\sp\utility::func_75C4("cockpit_pip_light", var_00);
  level scripts\sp\utility::func_178D(scripts\sp\utility::func_137AA, "pip_closed");
  scripts\sp\utility::func_178D(scripts\sp\utility::func_137AA, "death");
  scripts\sp\utility::func_57D6();
  stopFXOnTag(level._effect["cockpit_pip_light"], self, var_00);
}

#using_animtree("generic_human");

func_1063A(var_00, var_01, var_02) {
  var_03 = spawn("script_model", self.origin);
  var_00 = scripts\engine\utility::ter_op(isDefined(var_00), var_00, "body_un_jackal_pilots");
  var_03 setModel(var_00);

  if(!isDefined(var_01))
    var_01 = scripts\engine\utility::ter_op(randomint(100) < 50, "head_bg_var_head_sc_engineering_mate_head_male_bc_02", "head_bg_var_head_male_bc_07_head_male_bc_01");

  var_02 = scripts\engine\utility::ter_op(isDefined(var_02), var_02, "helmet_un_jackal_pilots_generic");
  var_03 attach(var_01);
  var_03 attach(var_02);
  var_03 glinton(#animtree);
  var_3.func_8C7E = % head;
  var_3.func_EF82 = % scripted_talking;
  return var_03;
}

func_B156(var_00, var_01, var_02, var_03) {
  var_04 = "tag_flash";

  if(!isDefined(level.func_1656))
    level.func_1656 = [];

  for(var_05 = 0; var_05 < var_00; var_5++) {
    thread scripts\sp\utility::play_sound_on_entity("jackal_missile_launch_space_npc");
    var_06 = anglesToForward(self gettagangles(var_04)) * 250;
    var_07 = self gettagorigin(var_04) + (var_06 - (0, 0, 90));
    var_08 = var_07 + anglesToForward(self.angles) * 10000;

    if(!isDefined(var_01)) {
      var_09 = bulletTrace(var_07, var_08, 0, self);
      var_08 = var_9["position"];
      var_10 = magicbullet("spaceship_forward_missile", var_07, var_08);
    } else {
      var_10 = magicbullet("spaceship_homing_missile", var_07, var_1.origin);
      var_10 thread func_B158(var_01, var_02);

      if(isDefined(var_03))
        var_10 thread func_699A(var_03, var_01);
    }

    if(isDefined(var_10))
      var_10 setCanDamage(0);

    if(var_04 == "tag_flash")
      var_04 = "tag_flash_2";
    else
      var_04 = "tag_flash";

    wait 0.3;
  }
}

func_B158(var_00, var_01) {
  self endon("entitydeleted");
  var_02 = distance(self.origin, var_0.origin);
  var_03 = scripts\sp\math::func_C097(5000, 12000, var_02);
  var_04 = scripts\sp\math::func_6A8E(0, 0.5, var_03);

  if(isDefined(var_01) && var_01) {} else
    wait(var_04);

  if(isDefined(var_00) && isvalidmissile(self) && isDefined(self))
    self missile_settargetent(var_00);

  self waittill("death");
  var_00 notify("missile_hit");
}

func_699A(var_00, var_01) {
  self endon("death");
  var_01 endon("death");

  for(;;) {
    if(distance(self.origin, var_1.origin) <= var_00) {
      var_01 notify("detonated");
      self detonate();
    }

    wait 0.05;
  }
}

func_C3DA(var_00, var_01, var_02) {
  self endon("stop_shooting");
  self endon("death");

  while(isDefined(self)) {
    func_C3D9(var_00, undefined, var_01, var_02);
    wait(randomfloatrange(0.3, 2));
  }
}

func_C3DB(var_00, var_01, var_02) {
  if(isDefined(self.func_EF4A)) {
    return;
  }
  self.func_EF4A = 1;

  if(isDefined(self.func_B6B6))
    var_03 = self.func_B6B6;
  else
    var_03 = "magic_spaceship_30mm_projectile";

  self endon("death");
  var_04 = undefined;
  var_05 = undefined;
  var_06 = "TAG_FLASH_right";

  foreach(var_08 in var_00) {
    if(isai(var_08) && !isalive(var_08)) {
      var_00 = scripts\engine\utility::array_remove(var_00, var_08);
      wait 0.05;
      continue;
    }

    if(scripts\sp\utility::hastag(self.model, var_06)) {
      var_09 = self gettagorigin(var_06) + anglesToForward(self.angles) * 240;
      var_10 = func_7D3F(var_8.origin, var_01, var_02);
      magicbullet(var_03, var_09, var_10, undefined, self);
    }

    if(var_06 == "TAG_FLASH_right")
      var_06 = "TAG_FLASH_left";
    else
      var_06 = "TAG_FLASH_right";

    wait 0.05;
  }

  self.func_EF4A = undefined;
}

func_C3D9(var_00, var_01, var_02, var_03) {
  self endon("death");
  self endon("entitydeleted");
  var_04 = undefined;
  var_05 = undefined;

  if(isDefined(self.func_B6B6))
    var_06 = self.func_B6B6;
  else
    var_06 = "magic_spaceship_30mm_projectile";

  var_07 = "tag_flash_right";

  if(!isDefined(var_01))
    var_01 = randomintrange(5, 15);

  var_08 = 1;

  if(isDefined(var_00))
    var_08 = 0;

  for(var_09 = 0; var_09 < var_01; var_9++) {
    var_10 = self gettagorigin(var_07) + anglesToForward(self.angles) * 20;

    if(var_08 || !isDefined(var_00))
      var_11 = var_10 + anglesToForward(self.angles) * 1000;
    else
      var_11 = func_7D3F(var_0.origin, var_02, var_03);

    magicbullet(var_06, var_10, var_11, undefined, self);

    if(var_07 == "tag_flash_right")
      var_07 = "tag_flash_left";
    else
      var_07 = "tag_flash_right";

    wait 0.05;
  }
}

func_7D3F(var_00, var_01, var_02) {
  if(isDefined(var_02)) {
    if(isDefined(var_01))
      return var_00 + scripts\engine\utility::randomvectorrange(var_01, var_02);
    else
      return var_00 + scripts\engine\utility::randomvectorrange(0, var_02);
  } else if(isDefined(var_01)) {
    if(isDefined(var_02))
      return var_00 + scripts\engine\utility::randomvectorrange(var_01, var_02);
    else
      return var_00 + scripts\engine\utility::randomvectorrange(0, var_01);
  }

  return var_00;
}

func_B155(var_00, var_01, var_02, var_03) {
  self notify("stop_MG_magic");
  self endon("death");
  self endon("stop_MG_magic");
  var_04 = "tag_flash";
  var_05 = "magic_spaceship_20mm_bullet";
  var_06 = gettime() + var_00 * 1000;

  if(isDefined(var_03))
    var_07 = var_03;
  else
    var_07 = 0.1;

  while(var_06 >= gettime()) {
    var_08 = anglestoaxis(self gettagangles(var_04));
    var_09 = var_8["forward"] * 250;
    var_10 = var_8["up"] * -90;
    var_11 = self gettagorigin(var_04) + var_09 + var_10;
    var_12 = var_11 + anglesToForward(self.angles) * 10000;

    if(isDefined(var_01)) {
      if(isDefined(var_1.model) && scripts\sp\utility::hastag(var_1.model, "tag_eye"))
        var_12 = var_01 gettagorigin("tag_eye");
      else
        var_12 = var_1.origin;
    } else {
      var_13 = bulletTrace(var_11, var_12, 0, self);
      var_12 = var_13["position"];
    }

    if(vectordot(var_8["forward"], var_12 - var_11) > 0.0) {
      var_14 = magicbullet(var_05, var_11, var_12);
      playFXOnTag(level._effect["30mm_flash"], self, var_04);

      if(isDefined(var_02))
        playFX(var_02, var_12);

      _bullettracer(self gettagorigin(var_04), var_12, var_05, 1);

      if(var_04 == "tag_flash")
        var_04 = "tag_flash_2";
      else
        var_04 = "tag_flash";
    }

    wait(var_07);
  }
}

func_9CBA(var_00) {
  switch (var_00) {
    case "sa_cruiser_00":
    case "ship_assault_00":
    case "sa_wounded":
    case "sa_vips":
    case "sa_empambush":
    case "sa_moon":
    case "sa_assassination":
      return 1;
    default:
      return 0;
  }
}

func_F43D(var_00, var_01) {
  if(!isDefined(var_01))
    var_01 = 0;

  if(isDefined(self.func_ED2D)) {
    switch (self.func_ED2D) {
      case "player":
        thread func_0BD9::func_556E();
        break;
      case "fake":
        self.func_ED2D = var_00;
        thread func_0C1F::func_552A();
        break;
      case "ai":
        self.func_ED2D = var_00;
        thread func_0C21::func_54F8();
        break;
      case "null":
        self.func_ED2D = var_00;
        break;
      default:
    }
  }

  switch (var_00) {
    case "player":
      self.func_ED2D = var_00;
      func_F387();
      thread func_0BD9::func_622B();
      break;
    case "fake":
      self.func_ED2D = var_00;
      func_F389("j_mainroot_ship");
      thread func_0C1F::func_61F8(var_01);
      break;
    case "ai":
      self.func_ED2D = var_00;
      func_F389("j_mainroot_ship");
      thread func_0C21::func_61CA();
      break;
    case "null":
      self.func_ED2D = var_00;
      func_F389("j_mainroot_ship");
      break;
    default:
  }
}

func_F389(var_00, var_01) {
  if(!isDefined(var_00))
    var_00 = "tag_origin";

  if(!isDefined(level.func_A056)) {
    return;
  }
  level.func_A056.func_3818 = scripts\engine\utility::array_removeundefined(level.func_A056.func_3818);

  if(!scripts\engine\utility::array_contains(level.func_A056.func_3818, self))
    level.func_A056.func_3818 = scripts\engine\utility::array_add(level.func_A056.func_3818, self);

  self.func_615D = spawnStruct();
  self.func_615D.func_7601 = var_00;
  self.func_615D.func_619D = 0;
  self.func_615D.func_C78B = 0;

  if(isDefined(var_01))
    self.func_615D.func_C76E = var_01;
}

func_F387() {
  if(!isDefined(level.func_A056) || !isDefined(level.func_A056.func_3818)) {
    return;
  }
  if(!scripts\engine\utility::array_contains(level.func_A056.func_3818, self))
    level.func_A056.func_3818 = scripts\engine\utility::array_remove(level.func_A056.func_3818, self);
}

func_A169() {
  self endon("stop_displaying_speed");
  self endon("death");
  var_00 = (1, 0, 0);

  for(;;)
    wait 0.05;
}

func_A207(var_00) {
  if(!isDefined(self.func_8E5D))
    self.func_8E5D = [];

  if(!scripts\engine\utility::array_contains(self.func_8E5D, var_00))
    self.func_8E5D = scripts\engine\utility::array_add(self.func_8E5D, var_00);

  self _meth_8189(var_00);
}

func_A335(var_00) {
  if(!isDefined(self.func_8E5D)) {
    return;
  }
  if(!scripts\engine\utility::array_contains(self.func_8E5D, var_00)) {
    return;
  }
  self.func_8E5D = scripts\engine\utility::array_remove(self.func_8E5D, var_00);
  self showallparts();

  foreach(var_02 in self.func_8E5D)
  self _meth_8189(var_02);
}

func_A334() {
  self.func_8E5D = [];
  self showallparts();
}

func_A208(var_00) {
  if(!isDefined(var_00))
    var_00 = 1;

  if(var_00) {
    func_A207("j_mainroot");
    func_A207("tag_cambone");
  } else {
    func_A335("j_mainroot");
    func_A335("tag_cambone");
  }
}

func_1985() {
  if(isDefined(self.func_4074)) {
    return;
  }
  self.func_4074 = [];
  self waittill("entitydeleted");

  if(issentient(self))
    self freeentitysentient();

  level.func_A056.func_1630 = scripts\engine\utility::array_remove(level.func_A056.func_1630, self);

  if(self.script_team == "allies") {
    if(scripts\engine\utility::array_contains(level.func_A056.func_1914, self))
      level.func_A056.func_1914 = scripts\engine\utility::array_remove(level.func_A056.func_1914, self);
  } else if(scripts\engine\utility::array_contains(level.func_A056.func_191E, self))
    level.func_A056.func_191E = scripts\engine\utility::array_remove(level.func_A056.func_191E, self);

  foreach(var_01 in self.func_4074) {
    if(isDefined(var_01))
      var_01 delete();
  }
}

func_1980(var_00, var_01) {
  if(isDefined(var_00)) {}

  if(isDefined(var_01)) {}

  self.func_154D = var_00;
  self.func_734A = var_01;
}

func_6B4C(var_00, var_01) {
  if(!isDefined(var_01))
    var_01 = 0;

  thread func_0C1A::func_A3B6(var_00, 1.0);
  thread func_0C20::func_A3B7(var_00);

  if(!var_01)
    thread func_0C18::func_A3B5(var_00);

  self.func_6B4E = var_00;
}

func_6B4D() {
  self.audio.state = undefined;
  self.audio.func_552E = undefined;
  self.fx.state = undefined;

  if(isDefined(self.fx.func_552E))
    self thread[[self.fx.func_552E]]();

  self.fx.func_552E = undefined;
  self.anims.state = undefined;
  self.func_6B4E = undefined;
}

func_A19D(var_00) {
  if(!isDefined(var_00))
    var_00 = 1;

  if(var_00)
    setdvar("scr_jackalDemigod", 1);
  else
    setdvar("scr_jackalDemigod", 0);
}

func_A324(var_00) {
  func_A144();
  self setModel(var_00);
  func_A0AF();
}

func_A0AF() {
  if(isDefined(self.func_C899) && self.func_C899 == 1) {
    return;
  }
  if(self.model != "veh_mil_air_un_jackal_02") {
    return;
  }
  self attach("veh_mil_air_un_jackal_02_panels", "j_panel_hide", 1);
  self.func_C899 = 1;
}

func_A144() {
  if(!isDefined(self.func_C899) || self.func_C899 == 0) {
    return;
  }
  if(self.model != "veh_mil_air_un_jackal_02") {
    return;
  }
  self detach("veh_mil_air_un_jackal_02_panels", "j_panel_hide");
  self.func_C899 = 0;
}

func_A1BC() {
  if(isDefined(self.rockets)) {
    return;
  }
  func_0C20::func_AA92();
  func_0C20::func_AA91();
  func_A144();
  var_00 = func_107BA("j_rocket_booster_rear_left1");
  var_01 = func_107BA("j_rocket_booster_rear_left2");
  var_02 = func_107BA("j_rocket_booster_rear_right1");
  var_03 = func_107BA("j_rocket_booster_rear_right2");
  self.rockets = [var_00, var_01, var_02, var_03];
  self.func_4074 = scripts\engine\utility::array_combine(self.func_4074, self.rockets);
}

func_107BA(var_00) {
  var_01 = self gettagorigin(var_00);
  var_02 = spawn("script_model", var_01);
  var_02 setModel("veh_mil_air_un_jackal_01_rocket");
  var_02 linkto(self, var_00, (0, 0, 0), (0, 0, 0));
  return var_02;
}

func_ACF8() {
  for(;;) {
    if(!isDefined(level.func_D127))
      var_00 = level.player;
    else
      var_00 = level.func_D127;

    wait 0.05;
  }
}

func_A2DC() {
  if(!isDefined(self.rockets)) {
    return;
  }
  foreach(var_01 in self.rockets) {
    self.func_4074 = scripts\engine\utility::array_remove(self.func_4074, var_01);
    var_01 delete();
  }

  self.rockets = undefined;
}

func_A19F() {
  if(isDefined(self.fx.func_13D7E) && self.fx.func_13D7E) {
    return;
  }
  self endon("entitydeleted");
  self endon("dont_start_winglights");
  self notify("dont_stop_winglights");
  var_00 = self.script_team + "_winglight";
  var_01 = self.script_team + "_taillight";
  var_02 = self.script_team + "_bellylight";
  scripts\sp\utility::func_75C4(var_00, "tag_wing_front_left", 0, "dont_start_winglights");
  scripts\sp\utility::func_75C4(var_00, "tag_wing_front_right", 0, "dont_start_winglights");
  scripts\sp\utility::func_75C4(var_01, "tag_wing_rear_left", 0, "dont_start_winglights");
  scripts\sp\utility::func_75C4(var_01, "tag_wing_rear_right", 0, "dont_start_winglights");
  scripts\sp\utility::func_75C4(var_02, "tag_bottom_light", 0, "dont_start_winglights");
  self.fx.func_13D7E = 1;
}

func_A167() {
  if(!isDefined(self.fx.func_13D7E) || isDefined(self.fx.func_13D7E) && !self.fx.func_13D7E) {
    return;
  }
  self endon("entitydeleted");
  self endon("dont_stop_winglights");
  self notify("dont_start_winglights");
  var_00 = self.script_team + "_winglight";
  var_01 = self.script_team + "_taillight";
  var_02 = self.script_team + "_bellylight";
  scripts\sp\utility::func_75F8(var_00, "tag_wing_front_left", 0, "dont_stop_winglights");
  scripts\sp\utility::func_75F8(var_00, "tag_wing_front_right", 0, "dont_stop_winglights");
  scripts\sp\utility::func_75F8(var_01, "tag_wing_rear_left", 0, "dont_stop_winglights");
  scripts\sp\utility::func_75F8(var_01, "tag_wing_rear_right", 0, "dont_stop_winglights");
  scripts\sp\utility::func_75F8(var_02, "tag_bottom_light", 0, "dont_stop_winglights");
  self.fx.func_13D7E = 0;
}

func_77E0() {
  var_00 = level.func_A056.func_1630;
  var_00 = scripts\engine\utility::array_removeundefined(var_00);
  return var_00;
}

func_77D8() {
  var_00 = level.func_A056.func_191E;
  var_00 = scripts\engine\utility::array_removeundefined(var_00);
  return var_00;
}

func_19A4(var_00) {
  self.var_1198.func_90F3 = var_00;
}

func_19B8(var_00) {
  if(!isDefined(var_00))
    var_00 = 1;

  if(var_00)
    self.func_3D4F = 1;
  else
    self.func_3D4F = undefined;
}

func_19AA(var_00) {
  self giveflagassistedcapturepoints(var_00);
  self.weapon = var_00;
  self.func_13C87 = weaponfiretime(self.weapon);
  self.func_13C87 = max(self.func_13C87, 0.05);
}

func_19A8(var_00) {
  self.var_1198.func_D9BA = var_00;
}

func_19A6(var_00) {
  if(isDefined(var_00) && var_00) {
    func_19B0("fly");
    self.var_1198.func_AAB2 = var_00;
  } else {
    self.var_1198.func_AAB2 = 0;
    func_19B0("none");
  }
}

func_198F(var_00) {
  if(!isDefined(var_00))
    var_00 = 1;

  self _meth_8555(var_00);
}

func_1983() {
  if(!isDefined(self.var_1198)) {
    return;
  }
  if(isDefined(self.var_1198.func_A421)) {
    self.var_1198.func_A421 func_1983();
    return;
  }

  if(isDefined(self.func_A420)) {
    foreach(var_01 in self.func_A420) {
      if(isalive(var_01)) {
        var_1.var_1198.func_A421 = undefined;
        var_01 func_19B7();
      }
    }

    self.func_A420 = undefined;
  }
}

func_199F() {
  if(isDefined(self.var_1198.func_A421))
    self.var_1198.func_A421.func_A420 = scripts\engine\utility::array_remove(self.var_1198.func_A421.func_A420, self);

  self.var_1198.func_A421 = undefined;
  func_19B7();
}

func_A253(var_00) {
  if(!isDefined(self.func_A420))
    self.func_A420 = [];

  self.func_A420[self.func_A420.size] = var_00;
}

func_1991(var_00) {
  self endon("death");
  self notify("new_evade_anim");

  if(isDefined(self.func_67C7) && self.func_67C7) {
    return;
  }
  if(isDefined(var_00)) {
    var_01 = var_00;
    var_02 = 1;
  } else {
    var_02 = 0;
    var_01 = level.func_A065["evasion"][level.func_A056.func_67D8];
  }

  self _meth_82AB(var_01, 1, 0.0);
  self give_attacker_kill_rewards(level.func_A065["evasion_overlay"], 1.0);

  if(!var_02) {
    level.func_A056.func_67D8++;

    if(level.func_A056.func_67D8 == level.func_A065["evasion"].size) {
      level.func_A056.func_67D8 = 0;
      level.func_A065["evasion"] = scripts\engine\utility::array_randomize(level.func_A065["evasion"]);
    }
  }

  self.func_67C7 = 1;
  var_03 = 0.7;
  wait(getanimlength(var_01) * var_03);
  self.func_67C7 = 0;
  self endon("new_evade_anim");
  wait(getanimlength(var_01) * (1 - var_03));
}

func_199E(var_00, var_01) {
  self.var_1198.func_A421 = var_00;
  var_00 func_A253(self);

  if(!isDefined(var_01)) {
    var_01 = self.origin - var_0.origin;
    var_01 = rotatevectorinverted(var_01, var_0.angles);
  }

  func_1994(var_00, var_01);
}

func_19B3(var_00, var_01) {
  self.var_1198.func_10A4D[var_00] = var_01;
}

func_19B4(var_00) {
  self.var_1198.func_10A4B = var_00;
}

func_A202(var_00) {
  var_01 = self gettagorigin("tag_flash_right");
  var_02 = var_0.origin + (0, 0, 30);
  var_03 = scripts\engine\trace::create_contents(1, 1, 0, 1, 1, 1);
  var_04 = scripts\engine\trace::ray_trace(var_01, var_02, undefined, var_03, 1);

  if(isDefined(var_4["entity"]) && var_4["entity"] == var_00)
    return 1;

  return 0;
}

func_A288(var_00) {
  if(var_00)
    func_1980(1, 1);
  else
    func_1980();
}

func_A0B3(var_00) {
  self.var_1198.func_2520 = var_00;
}

func_A342(var_00, var_01, var_02) {
  if(isDefined(self.var_1198))
    func_1981();

  if(!isDefined(var_00)) {}

  if(isDefined(var_02) && var_02)
    var_03 = self.origin;
  else
    var_03 = undefined;

  func_0C24::func_10A46(var_00, var_01, var_03);
}

func_F5BD(var_00) {
  switch (var_00) {
    case "runway":
      self.func_11474 = func_0BDB::func_1147D;
      break;
    case "retribution":
      self.func_11474 = func_0BDB::func_1147C;
      break;
    case "shipcrib":
      self.func_11474 = func_0BDB::func_11486;
      break;
    case "instant":
      self.func_11474 = func_0BDB::func_11478;
      break;
    case "vtol":
      self.func_11474 = func_0BDB::func_1148A;
      break;
    case "hovering":
      self.func_11474 = func_0BDB::func_11477;
      break;
    case "ship_assault_gunner":
      self.func_11474 = func_0BDB::func_11484;
      break;
    case "phspace_launch":
      self.func_11474 = func_0BDB::func_11479;
      break;
    default:
  }

  self.func_11488 = var_00;
}

func_7BBA() {
  var_00 = level.player _meth_8473();

  if(isDefined(var_00))
    return var_0.origin;
  else
    return level.player.origin;
}

func_7BB9() {
  var_00 = level.player _meth_8473();

  if(isDefined(var_00))
    return var_0.angles;
  else
    return level.player.angles;
}

func_F448(var_00) {
  switch (var_00) {
    case "instant":
      self.func_A7B9 = func_0BDB::func_A7BB;
      break;
    default:
  }

  self.func_A7C1 = var_00;
}

func_F48D(var_00) {
  switch (var_00) {
    case "default_landed":
      self.func_BBD4 = func_0BDB::func_BBD0;
      func_F420(500, 135, -30, 1, 1);
      break;
    case "runway":
      self.func_BBD4 = func_0BDB::func_BBE4;
      func_F420(500, 135, 0, 1, 1);
      break;
    case "runway_moon":
      self.func_BBD4 = func_0BDB::func_BBE5;
      func_F420(500, 135, 0, 1, 1);
      break;
    case "titan_breifing":
      self.func_BBD4 = func_0BDB::func_BBE9;
      func_F420(500, 135, 30, 1, 1);
      break;
    case "instant_fly":
      self.func_BBD4 = func_0BDB::func_BBDB;
      func_F420(500, 135, -30, 0, 0);
      break;
    case "instant_hover":
      self.func_BBD4 = func_0BDB::func_BBD8;
      func_F420(500, 135, -30, 0, 0);
      break;
    case "instant_land":
      self.func_BBD4 = func_0BDB::func_BBD9;
      func_F420(500, 135, -30, 0, 0);
      break;
    case "jump_in":
      func_F420(500, 135, 30, 1, 1);
      self.func_BBD4 = func_0BDB::func_BBDD;
      break;
    case "zero_g":
      func_F420(500, 135, 30, 1, 1);
      self.func_BBD4 = func_0BDB::func_BBEF;
      break;
    case "zero_g_enemy":
      func_F420(500, 135, 30, 1, 1);
      self.func_BBD4 = func_0BDB::func_BBF0;
      break;
    case "crib_launch":
      func_F420(500, 135, -30, 1, 1);
      self.func_BBD4 = func_0BDB::func_BBCF;
      break;
    case "shipcrib_europa_launch":
      func_F420(500, 135, -30, 0, 1);
      self.func_BBD4 = func_0BDB::func_BBE6;
      break;
    case "retribution":
      func_F420(500, 135, -30, 1, 1);
      self.func_BBD4 = func_0BDB::func_BBD9;
      break;
    case "visor_pulldown_landed":
      func_F420(500, 135, -30, 1, 1);
      self.func_BBD4 = func_0BDB::func_BBDE;
      break;
    default:
  }

  self.func_BBEB = var_00;
}

func_F48C(var_00, var_01, var_02, var_03) {
  if(isDefined(var_00))
    self.func_1EE1 = var_00;

  if(isDefined(var_01))
    self.func_1EE2 = var_01;

  if(isDefined(var_02))
    self.func_1F20 = var_02;

  if(isDefined(var_02))
    self.func_1F21 = var_03;
}

func_F358(var_00) {
  switch (var_00) {
    case "default_landed":
      self.func_5688 = func_0BDB::func_5685;
      break;
    case "zero_g":
      self.func_5688 = func_0BDB::func_56A6;
      break;
    case "crib_craneride":
      self.func_5688 = func_0BDB::func_5684;
      break;
    case "dismount_shipcrib_moon":
      self.func_5688 = func_0BDB::func_56A0;
      break;
    case "dismount_shipcrib_gravity":
      self.func_5688 = func_0BDB::func_569F;
      break;
    case "instant":
      self.func_5688 = func_0BDB::func_568E;
      break;
    case "moon_dismount":
      self.func_5688 = func_0BDB::func_5695;
      break;
    case "heist_mons_breach":
      self.func_5688 = func_0BDB::func_568B;
      break;
    default:
  }

  self.func_56A4 = var_00;
}

func_F420(var_00, var_01, var_02, var_03, var_04) {
  if(!isDefined(self.func_99F5)) {
    self.func_99F5 = spawnStruct();
    self.func_99F5.func_BBF1 = 0;
    self.func_99F5.func_AB4B = 1;
    self.func_99F5.func_E526 = 1;
    self.func_99F5.draw_distance = 500;
    self.func_99F5.func_12FC3 = 130;
    self.func_99F5.height = -30;
    self.func_99F5.func_56B6 = 35;
  }

  if(isDefined(var_03))
    self.func_99F5.func_AB4B = var_03;

  if(isDefined(var_04))
    self.func_99F5.func_E526 = var_04;

  if(isDefined(var_00))
    self.func_99F5.draw_distance = var_00;

  if(isDefined(var_01))
    self.func_99F5.func_12FC3 = var_01;

  if(isDefined(var_02))
    self.func_99F5.height = var_02;

  func_DE6D();
}

#using_animtree("jackal");

func_A2DE(var_00, var_01, var_02, var_03) {
  var_01 = 0;

  if(!isDefined(var_00))
    var_00 = 1;

  if(!isDefined(var_02))
    var_02 = 0;

  if(!isDefined(var_03))
    var_03 = 0;

  if(!isDefined(var_01))
    var_01 = 0.2;

  self _meth_848F(var_00);

  if(var_00 && !var_02) {
    self clearanim( % jackal_thrust_p, var_01);
    self clearanim( % jackal_motion_idle_p, var_01);
    self clearanim( % root, var_01);
    self clearanim( % jackal_assault_lhand_fb_range_p, var_01);
    self clearanim( % jackal_assault_lhand_lr_range_p, var_01);
    self clearanim( % jackal_assault_rhand_fb_range_p, var_01);
    self clearanim( % jackal_assault_rhand_lr_range_p, var_01);
    self clearanim( % jackal_strike_lhand_fb_range_p, var_01);
    self clearanim( % jackal_strike_lhand_lr_range_p, var_01);
    self clearanim( % jackal_strike_rhand_fb_range_p, var_01);
    self clearanim( % jackal_strike_rhand_lr_range_p, var_01);
  }

  if(var_00 && !var_03) {
    self clearanim( % jackal_weapon_switch_p, var_01);
    self clearanim( % jackal_weapon_drop_p, var_01);
    self clearanim( % jackal_vehicle_weap_primary_fire_l_p, var_01);
    self clearanim( % jackal_vehicle_weap_primary_fire_r_p, var_01);
    self clearanim( % jackal_vehicle_weap_secondary_fire_l_p, var_01);
    self clearanim( % jackal_vehicle_weap_secondary_fire_r_p, var_01);
  }
}

func_A16F() {
  while(level.func_A056.func_56F9.size == 0)
    wait 0.05;

  for(;;) {
    while(!isDefined(level.func_D127))
      wait 0.05;

    level.func_A056.func_56F9 = scripts\engine\utility::array_removeundefined(level.func_A056.func_56F9);

    if(level.func_A056.func_56F9.size == 0) {
      break;
    }
    var_00 = 1;
    var_01 = 1;
    var_02 = anglesToForward(level.func_D127.angles);
    var_03 = level.func_D127.origin;

    foreach(var_05 in level.func_A056.func_56F9) {
      if(!isDefined(var_05)) {
        continue;
      }
      if(isDefined(var_5.func_A496)) {
        var_06 = level.func_D127.origin - var_5.origin;
        var_07 = rotatevectorinverted(var_06, var_5.angles);
        var_08 = func_394B(var_7[0], var_5.func_A496);
        var_09 = func_394B(var_7[1], var_5.func_A497);
        var_10 = func_394B(var_7[2], var_5.func_A498);
        var_07 = (var_08, var_09, var_10);
        var_06 = rotatevector(var_07, var_5.angles);
        var_5.func_A493 = var_5.origin + var_06;
      } else
        var_5.func_A493 = var_5.origin;

      var_11 = distance(var_5.func_A493, level.func_D127.origin);
      var_12 = scripts\sp\math::func_C097(var_5.func_A492, var_5.func_A490, var_11);
      var_13 = scripts\sp\math::func_6A8E(var_5.func_A494, 1, var_12);

      if(isDefined(var_5.func_A491)) {
        var_14 = vectordot(vectornormalize(var_5.func_A493 - var_03), var_02);
        var_12 = scripts\sp\math::func_C097(-0.5, 0.2, var_14);
        var_13 = scripts\sp\math::func_6A8E(1, var_13, var_12);
      }

      if(isDefined(var_5.func_A494))
        var_15 = scripts\sp\math::func_6A8E(var_5.func_A48F, 1, var_12);

      if(var_13 < var_00)
        var_00 = var_13;

      if(var_13 < var_00)
        var_00 = var_13;
    }

    func_A301(var_00, 0.05, "radius_dist");
    func_A2FC(var_01, 0.05, "radius_dist");
    wait 0.05;
  }

  level.func_A056.func_56F9 = undefined;
}

func_394B(var_00, var_01) {
  var_01 = var_01 * 0.5;

  if(var_00 > var_01)
    var_00 = var_01;
  else if(var_00 < var_01 * -1)
    var_00 = var_01 * -1;

  return var_00;
}

func_A2DF() {
  thread func_A2E0();
}

func_A2E0() {
  if(!scripts\sp\utility::func_B324()) {
    return;
  }
  level.func_A056.func_E1A6 = scripts\engine\utility::array_removeundefined(level.func_A056.func_E1A6);
  level.func_A056.func_E1A6 = scripts\engine\utility::array_add(level.func_A056.func_E1A6, self);
  var_00 = "repulser_force" + level.func_A056.func_E1A5;
  level.func_A056.func_E1A5++;

  for(;;) {
    if(!isDefined(level.func_D127)) {
      wait 0.05;
      continue;
    }

    if(!isDefined(self)) {
      break;
    }
    scripts\engine\utility::waittill_any("slowdown_point_factored", "death", "repulser_removed");

    if(!isDefined(self) || !scripts\engine\utility::array_contains(level.func_A056.func_E1A6, self)) {
      break;
    }
    if(level.func_D127.func_C2CB) {
      var_01 = level.func_D127.spaceship_vel;
      var_02 = self.func_A493 - level.func_D127.origin;
      var_03 = length(var_02);
      var_04 = scripts\sp\math::func_C097(-200, 750, var_03);
      var_05 = scripts\sp\math::func_6A8E(self.origin, self.func_A493, var_04);
      var_06 = var_05 - level.func_D127.origin;
      var_07 = vectornormalize(var_06);
      var_08 = vectordot(var_01, var_07);
      var_08 = max(0, var_08);
      var_03 = length(var_02);
      var_04 = scripts\sp\math::func_C097(2000, 8000, var_03);
      var_09 = scripts\sp\math::func_6A8E(-0.5 * var_08, 0, var_04);
      var_10 = scripts\sp\math::func_6A8E(var_08, 0, var_04);
      var_11 = var_09 * var_07;
      var_12 = 1 - scripts\sp\math::func_C097(20, 100, var_10);
      func_A301(var_12, 0, var_00);
      func_A2FC(var_12, 0, var_00);
      func_A078(var_11, 0, var_00);
      continue;
    }

    func_A078((0, 0, 0), 0, var_00);
    func_A301(1, 0, var_00);
    func_A2FC(1, 0, var_00);
  }

  func_A34D();
  func_A078((0, 0, 0), 0, var_00);
}

func_A34D() {
  if(isDefined(self) && scripts\engine\utility::array_contains(level.func_A056.func_E1A6, self)) {
    self notify("repulser_removed");
    level.func_A056.func_E1A6 = scripts\engine\utility::array_remove(level.func_A056.func_E1A6, self);
  }
}

func_A16E(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07) {
  if(!isDefined(level.func_A056.func_56F9)) {
    level.func_A056.func_56F9 = [];
    level thread func_A16F();
  }

  self.func_A492 = var_00;
  self.func_A490 = var_01;
  self.func_A494 = var_02;

  if(isDefined(var_03))
    self.func_A48F = var_03;

  if(isDefined(var_04)) {
    self.func_A496 = var_04;
    self.func_A497 = var_05;
    self.func_A498 = var_06;
  }

  if(isDefined(var_07))
    self.func_A491 = var_07;
  else
    self.func_A491 = 0;

  self.func_A495 = 1;
  level.func_A056.func_56F9 = scripts\engine\utility::array_add(level.func_A056.func_56F9, self);
}

func_A16B(var_00) {
  thread func_A16C(var_00);
}

func_A16C(var_00) {
  self endon("death");

  if(isDefined(var_00)) {
    for(var_01 = var_00; var_01 > 0; var_01 = var_01 - 0.05) {
      self.func_A495 = scripts\sp\math::func_C097(0, var_00, var_01);
      wait 0.05;
    }
  }

  level.func_A056.func_56F9 = scripts\engine\utility::array_remove(level.func_A056.func_56F9, self);
}

func_A25B(var_00, var_01, var_02, var_03, var_04, var_05) {
  if(!isDefined(level.func_D127.linked_ents))
    level.func_D127.linked_ents = [];

  level.func_D127.linked_ents = scripts\engine\utility::array_removeundefined(level.func_D127.linked_ents);
  self.func_AD25 = var_02;
  self.func_AD19 = var_03;
  self.func_AD42 = var_01;

  if(!scripts\engine\utility::array_contains(level.func_D127.linked_ents, self))
    level.func_D127.linked_ents = scripts\engine\utility::array_add(level.func_D127.linked_ents, self);

  if(isDefined(var_05) && var_05)
    self linkto(level.func_D127, var_01, var_02, var_03);
  else if(!isDefined(var_04)) {
    level.player.spaceship_linked_ent = self;
    level.player _meth_8468(self, var_01, var_00, var_02, var_03);
  } else {
    self.start = scripts\engine\utility::spawn_tag_origin(self.origin, self.angles - (0, 180, 0));
    thread func_2B74(self.start, level.func_D127, var_00, 0, "tag_origin", "j_canopy");
  }
}

func_A387() {
  if(isDefined(level.func_D127) && isDefined(level.func_D127.linked_ents) && scripts\engine\utility::array_contains(level.func_D127.linked_ents, self)) {
    level.func_D127.linked_ents = scripts\engine\utility::array_remove(level.func_D127.linked_ents, self);

    if(!isDefined(level.player.spaceship_linked_ent) || level.player.spaceship_linked_ent == self) {
      level.player _meth_8469();
      level.player.spaceship_linked_ent = undefined;
    }
  }
}

func_A386(var_00) {
  if(!isDefined(var_00))
    var_00 = 1;

  level.player _meth_8490("unlimited_boost", var_00);
}

func_A160(var_00, var_01) {
  if(!isDefined(var_00))
    var_00 = 1;

  if(!isDefined(var_01))
    var_01 = 0.0;

  if(var_00) {
    level.player scripts\sp\utility::func_65E1("disable_jackal_quickturn");
    var_02 = 0;
  } else {
    level.player scripts\sp\utility::func_65DD("disable_jackal_quickturn");
    var_02 = 1;
  }

  level.func_D127 thread func_DBA5(var_02, var_01);
}

func_DBA5(var_00, var_01) {
  self notify("blend_quickturn_master");
  self endon("blend_quickturn_master");

  if(!isDefined(self.func_DBA2)) {
    return;
  }
  if(var_01 == 0) {
    self.func_DBA2.func_B3D1 = var_00;
    return;
  }

  self.func_DBA2.func_2B8D = 1;
  var_02 = (var_00 - self.func_DBA2.func_B3D1) / var_01 * 0.05;
  var_03 = self.func_DBA2.func_B3D1;
  var_04 = var_01;

  while(var_04 > 0) {
    var_03 = var_03 + var_02;
    self.func_DBA2.func_B3D1 = clamp(var_03, 0, 1);
    var_04 = var_04 - 0.05;
    self notify("quickturn_master_blend_complete");
    level.player waittill("on_player_update");
  }

  self.func_DBA2.func_B3D1 = var_00;
  self notify("quickturn_master_blend_complete");
  self.func_DBA2.func_2B8D = 0;
}

func_12DCD(var_00) {
  var_01 = ["weapons", "thrusters", "hull", "none"];

  if(!scripts\engine\utility::array_contains(var_01, var_00)) {}

  level.func_A056.func_D3C1 = var_00;
  func_12DD0(var_00 == "weapons");
  func_12DCF(var_00 == "thrusters");
  func_12DCE(var_00 == "hull");
}

func_12DD0(var_00) {
  if(isDefined(level.func_D127.func_4C15))
    level.func_D127 func_0BD9::func_D17E();

  if(isDefined(level.func_D127.missiles))
    func_0BDD::func_A27B();
}

func_12DCF(var_00) {
  level.func_D127 func_0BD9::func_A31B();

  if(var_00) {
    return;
  }
  return;
}

func_12DCE(var_00) {
  level.func_D127 func_0BD5::func_F481();

  if(var_00) {
    return;
  }
  return;
}

func_A07D() {
  if(!scripts\sp\utility::func_B324()) {
    return;
  }
  if(isDefined(self.func_4F5E))
    self.func_4F5E delete();

  self.func_FF24 = 1;

  if(func_A2A7()) {
    return;
  }
  var_00 = func_0A2F::func_D9FB();

  if(self.model == "veh_mil_air_un_jackal_landed_03b")
    var_01 = (-3.99147, 0, -15.6889);
  else
    var_01 = (0, 0, 0);

  self.func_4F5E = spawn("script_model", self.origin);
  self.func_4F5E setModel(var_00);
  self.func_4F5E linkto(self, "tag_body", var_01, (0, 0, 0));
}

func_A077(var_00) {
  if(isDefined(self.func_4F5E))
    self.func_4F5E delete();

  var_01 = strtok(var_00, "_");
  var_02 = var_1.size - 1;
  var_03 = "livery_" + var_1[var_02 - 1] + "_" + var_1[var_02] + "_tr";

  if(!scripts\engine\utility::flag(var_03 + "_loaded"))
    scripts\sp\utility::func_12641(var_03);

  self.func_4F5E = spawn("script_model", self.origin);
  self.func_4F5E setModel(var_00);
  self.func_4F5E linkto(self, "tag_body", (0, 0, 0), (0, 0, 0));
}

func_A2DA() {
  if(isDefined(self.func_4F5E))
    self.func_4F5E delete();
}

func_8B87() {
  if(self.func_93D2.size > 0)
    return 1;
  else
    return 0;
}

func_1378D(var_00) {
  self endon("death");

  for(;;) {
    if(func_9C1B(var_00)) {
      break;
    }
    wait 0.05;
  }
}

func_137C2(var_00) {
  self endon("death");

  for(;;) {
    if(!func_9C1B(var_00)) {
      break;
    }
    wait 0.05;
  }
}

func_9C1B(var_00) {
  var_01 = func_0B76::func_7A60(self.origin);

  if(var_01 > var_00)
    return 1;
  else
    return 0;
}

func_1378C(var_00) {
  self endon("death");

  for(;;) {
    if(func_9C1A(var_00)) {
      break;
    }
    wait 0.05;
  }
}

func_137C1(var_00) {
  self endon("death");

  for(;;) {
    if(!func_9C1A(var_00)) {
      break;
    }
    wait 0.05;
  }
}

func_9C1A(var_00) {
  var_01 = distance(self.origin, level.func_D127.origin);

  if(var_01 < var_00)
    return 1;
  else
    return 0;
}

func_A149(var_00) {
  if(!isDefined(var_00))
    var_00 = 1;

  if(var_00) {
    var_00 = 0;
    level.player scripts\sp\utility::func_65E1("disable_jackal_ads");
    level.player _meth_8490("disable_lockon", 1);
  } else {
    var_00 = 1;
    level.player scripts\sp\utility::func_65DD("disable_jackal_ads");

    if(!level.player scripts\sp\utility::func_65DB("disable_jackal_lockon"))
      level.player _meth_8490("disable_lockon", 0);
  }

  level.player allowads(var_00);
}

func_A14D(var_00) {
  if(!isDefined(var_00))
    var_00 = 1;

  level.player _meth_8490("disable_collision", var_00);

  if(var_00)
    _setsaveddvar("spaceshipResolvePenetration", 0);
  else
    _setsaveddvar("spaceshipResolvePenetration", 1);
}

func_A14A(var_00) {
  if(!isDefined(var_00))
    var_00 = 1;

  level.player _meth_8490("disable_boost", var_00);
}

func_A162(var_00) {
  if(!isDefined(var_00))
    var_00 = 1;

  if(var_00)
    level.player scripts\sp\utility::func_65E1("disable_jackal_targetAid");
  else
    level.player scripts\sp\utility::func_65DD("disable_jackal_targetAid");
}

func_A35D(var_00, var_01) {
  level notify("new_target_aid_pool");
  level.func_A056.func_EF83 = var_00;

  if(isDefined(var_01) && var_01)
    thread func_A35E();
}

func_A35E() {
  level endon("new_target_aid_pool");

  while(isDefined(level.func_A056.func_EF83) && level.func_A056.func_EF83.size > 0) {
    level.func_A056.func_EF83 = scripts\engine\utility::array_removeundefined(level.func_A056.func_EF83);
    wait 0.05;
  }

  level.func_A056.func_EF83 = undefined;
}

func_A163(var_00) {
  if(!isDefined(var_00))
    var_00 = 1;

  if(var_00)
    level.player scripts\sp\utility::func_65E1("disable_jackal_targetAid_update");
  else
    level.player scripts\sp\utility::func_65DD("disable_jackal_targetAid_update");
}

jackal_disable_damage_vision_distortion(var_00) {
  if(!isDefined(var_00))
    var_00 = 1;

  if(var_00)
    level.player scripts\sp\utility::func_65E1("disable_jackal_damage_vision_distortion");
  else
    level.player scripts\sp\utility::func_65DD("disable_jackal_damage_vision_distortion");
}

jackal_engine_throttle_sfx_volume(var_00, var_01) {
  if(!isDefined(var_01))
    var_01 = 0;

  var_00 = clamp(var_00, 0, 1);
  level.func_D127 thread jackal_engine_throttle_sfx_volume_internal(var_00, var_01);
}

jackal_engine_throttle_sfx_volume_internal(var_00, var_01) {
  self notify("new_engine_throttle_volume");
  self endon("new_engine_throttle_volume");
  self endon("player_exit_jackal");
  self endon("death");

  if(!isDefined(self.engine_master_volume))
    self.engine_master_volume = 0;

  var_02 = self.engine_master_volume;

  for(var_03 = var_01; var_03 > 0; var_03 = var_03 - 0.05) {
    var_04 = scripts\sp\math::func_C097(0, var_01, var_03);
    self.engine_master_volume = scripts\sp\math::func_6A8E(var_00, var_02, var_04);
    wait 0.05;
  }

  self.engine_master_volume = var_00;
}

func_A14C(var_00) {
  if(!isDefined(var_00))
    var_00 = 1;

  level.func_D127.func_5509 = var_00;
}

func_A15C(var_00) {
  if(!isDefined(var_00))
    var_00 = 1;

  if(var_00)
    level.player scripts\sp\utility::func_65E1("disable_jackal_mode_switch");
  else
    level.player scripts\sp\utility::func_65DD("disable_jackal_mode_switch");
}

func_A154(var_00) {
  if(!isDefined(var_00))
    var_00 = 1;

  if(var_00)
    level.player scripts\sp\utility::func_65E1("disable_jackal_cockpit_VO");
  else
    level.player scripts\sp\utility::func_65DD("disable_jackal_cockpit_VO");
}

func_A15B(var_00) {
  if(!isDefined(var_00))
    var_00 = 1;

  if(var_00)
    level.player scripts\sp\utility::func_65E1("disable_jackal_missiles");
  else
    level.player scripts\sp\utility::func_65DD("disable_jackal_missiles");
}

func_A14F(var_00) {
  if(!isDefined(var_00))
    var_00 = 1;

  if(var_00)
    level.player scripts\sp\utility::func_65E1("disable_jackal_emp");
  else
    level.player scripts\sp\utility::func_65DD("disable_jackal_emp");
}

func_A158(var_00) {
  if(!isDefined(var_00))
    var_00 = 1;

  if(var_00)
    level.player scripts\sp\utility::func_65E1("disable_jackal_map_boundary_autoturn");
  else
    level.player scripts\sp\utility::func_65DD("disable_jackal_map_boundary_autoturn");
}

func_A159(var_00) {
  if(!isDefined(var_00))
    var_00 = 1;

  if(var_00)
    level.player scripts\sp\utility::func_65E1("disable_jackal_map_boundary_push");
  else
    level.player scripts\sp\utility::func_65DD("disable_jackal_map_boundary_push");
}

func_A15A(var_00) {
  if(!isDefined(var_00))
    var_00 = 1;

  if(var_00)
    level.player scripts\sp\utility::func_65E1("disable_jackal_map_boundary_warning");
  else
    level.player scripts\sp\utility::func_65DD("disable_jackal_map_boundary_warning");
}

func_A155(var_00) {
  if(!isDefined(var_00))
    var_00 = 1;

  if(var_00)
    level.player scripts\sp\utility::func_65E1("disable_jackal_juke");
  else
    level.player scripts\sp\utility::func_65DD("disable_jackal_juke");

  level.player _meth_8490("disable_juke", var_00);
}

func_A161(var_00) {
  if(!isDefined(var_00))
    var_00 = 1;

  if(var_00)
    level.player scripts\sp\utility::func_65E1("disable_jackal_roll");
  else
    level.player scripts\sp\utility::func_65DD("disable_jackal_roll");

  if(scripts\sp\utility::func_D123())
    func_0BD9::func_F380();
}

func_A15E(var_00) {
  if(!isDefined(var_00))
    var_00 = 1;

  if(var_00)
    level.player scripts\sp\utility::func_65E1("disable_jackal_overheat");
  else
    level.player scripts\sp\utility::func_65DD("disable_jackal_overheat");
}

func_A14E(var_00) {
  if(!isDefined(var_00))
    var_00 = 1;

  if(var_00)
    level.player scripts\sp\utility::func_65E1("disable_jackal_dogfight");
  else
    level.player scripts\sp\utility::func_65DD("disable_jackal_dogfight");
}

func_A151(var_00) {
  if(!isDefined(var_00))
    var_00 = 1;

  if(var_00)
    level.player scripts\sp\utility::func_65E1("disable_jackal_flares");
  else
    level.player scripts\sp\utility::func_65DD("disable_jackal_flares");
}

func_A153(var_00, var_01) {
  if(!isDefined(var_00))
    var_00 = 1;

  if(!isDefined(var_01))
    var_01 = 0;

  if(var_00 && !level.player scripts\sp\utility::func_65DB("disable_jackal_guns")) {
    level.player scripts\sp\utility::func_65E1("disable_jackal_guns");
    func_A152(var_01);
  } else if(!var_00 && level.player scripts\sp\utility::func_65DB("disable_jackal_guns")) {
    level.player scripts\sp\utility::func_65DD("disable_jackal_guns");
    func_A19E(var_01);
  }
}

func_A152(var_00) {
  if(var_00)
    level.func_D127 notify("spaceship_weapon_state_change", "silent");

  level.func_D127 _meth_849E("spaceship_disabled_guns");
  thread func_A157();
  level.func_D127 _meth_849F(0);
  level.player allowads(0);
  setomnvar("ui_jackal_weapon_display_temp", 0);
}

func_A19E(var_00) {
  if(var_00)
    level.func_D127 notify("spaceship_weapon_state_change", "silent");

  level.func_D127 func_0BD9::func_D17E();

  if(!level.player scripts\sp\utility::func_65DB("disable_jackal_lockon"))
    level.player _meth_8490("disable_lockon", 0);

  level.func_D127 _meth_849F(1);
  level.player allowads(1);

  if(!level.player scripts\sp\utility::func_65DB("disable_jackal_overheat"))
    setomnvar("ui_jackal_weapon_display_temp", 1);
}

func_A166(var_00) {
  if(!isDefined(var_00))
    var_00 = 1;

  if(var_00)
    level.player scripts\sp\utility::func_65E1("disable_jackal_weapon_switch");
  else
    level.player scripts\sp\utility::func_65DD("disable_jackal_weapon_switch");
}

setentityowner(var_00) {
  self.missiles.count = self.missiles.count + var_00;

  if(self.missiles.count > self.missiles.func_B446)
    self.missiles.count = self.missiles.func_B446;

  setomnvar("ui_jackal_missile_count", self.missiles.count);
}

func_10CD8() {
  thread func_E047();
}

func_E047() {
  while(!isDefined(level.func_D127))
    wait 0.05;

  while(!isDefined(level.func_D127.missiles))
    wait 0.05;

  level.func_D127.missiles.count = 0;
  setomnvar("ui_jackal_missile_count", level.func_D127.missiles.count);
}

func_A157() {
  level.player endon("disable_jackal_guns");
  func_137DB();
  level.player _meth_8490("disable_lockon", 1);
}

func_13C11(var_00, var_01) {
  level.func_D127 endon("player_exit_jackal");

  if(isDefined(var_01))
    wait(var_01);

  level.player playSound(var_00);
}

func_A15F(var_00) {
  if(!isDefined(var_00))
    var_00 = 1;

  if(var_00)
    level.player scripts\sp\utility::func_65E1("disable_jackal_pilot_assist");
  else
    level.player scripts\sp\utility::func_65DD("disable_jackal_pilot_assist");

  level.player _meth_8490("disable_pilot_aim_assist", var_00);
  level.player _meth_8490("disable_pilot_move_assist", var_00);
}

func_A15D(var_00) {
  if(!isDefined(var_00))
    var_00 = 1;

  if(var_00)
    level.func_A056.func_1C54 = 0;
  else
    level.func_A056.func_1C54 = 1;
}

func_A14B(var_00) {
  if(!isDefined(var_00))
    var_00 = 1;

  if(var_00)
    level.func_A056.func_1C3C = 0;
  else
    level.func_A056.func_1C3C = 1;
}

func_A165(var_00) {
  if(!isDefined(var_00))
    var_00 = 1;

  if(var_00)
    level.func_A056.func_1C6D = 0;
  else
    level.func_A056.func_1C6D = 1;
}

func_A1AA(var_00, var_01, var_02, var_03, var_04) {
  var_05 = spawnStruct();
  var_5.func_10974 = var_01;
  var_5.main = var_02;
  var_5.func_4623 = var_03;
  var_5.func_C6B4 = var_04;
  var_5.func_54F1 = 0;
  var_5.cooling_down = 0;
  var_5.running = 0;
  level.func_A056.func_68B3.func_68B6[var_00] = var_05;
}

func_A1AD(var_00) {
  level.func_A056.func_68B3.func_68B6 = scripts\sp\utility::func_22B2(level.func_A056.func_68B3.func_68B6, var_00);
}

func_A1AB(var_00, var_01) {
  if(!isDefined(var_01))
    var_01 = 1;

  if(!isDefined(level.func_A056.func_68B3.func_68B6[var_00])) {
    return;
  }
  level.func_A056.func_68B3.func_68B6[var_00].func_54F1 = var_01;
}

jackal_eventmanager_event_is_running(var_00) {
  if(!isDefined(level.func_A056.func_68B3.func_68B6[var_00]))
    return 0;

  return level.func_A056.func_68B3.func_68B6[var_00].running;
}

func_A1AE(var_00) {
  while(!isDefined(level.func_A056.func_68B3.func_68B6[var_00]))
    wait 0.05;
}

func_A1AC(var_00) {
  return isDefined(level.func_A056.func_68B3.func_68B6[var_00]);
}

func_A1A9(var_00) {
  if(!isDefined(var_00))
    var_00 = 1;

  level.func_A056.func_68B3.func_54F1 = var_00;
}

func_A1DD(var_00) {
  if(!isDefined(var_00))
    var_00 = 0;

  if(!isstring(var_00) && var_00 == 0) {
    level.player scripts\sp\utility::func_65DD("jackal_force_mode");
    level.func_D127.func_72A8 = undefined;
  } else {
    level.player scripts\sp\utility::func_65E1("jackal_force_mode");
    level.func_D127.func_72A8 = var_00;
    level.func_D127 _meth_8491(var_00);
  }
}

func_A1DC(var_00) {
  if(!isDefined(var_00) || var_00 == 0)
    var_00 = 0;

  level.func_A056.func_6F90 = var_00;
}

func_A164(var_00) {
  if(!isDefined(var_00))
    var_00 = 1;

  if(var_00)
    level.func_A056.func_1C6C = 0;
  else
    level.func_A056.func_1C6C = 1;

  level notify("notify_new_jackal_speed_zone");
}

func_A156(var_00) {
  if(scripts\sp\utility::func_93A6()) {
    return;
  }
  if(!isDefined(var_00))
    var_00 = 1;

  level.func_A056.targets = scripts\engine\utility::array_removeundefined(level.func_A056.targets);

  if(var_00) {
    level.player scripts\sp\utility::func_65E1("disable_jackal_lockon");

    foreach(var_02 in level.func_A056.targets)
    var_02 func_105D9();

    setomnvar("ui_jackal_callouts_enabled", 0);
  } else {
    level.player scripts\sp\utility::func_65DD("disable_jackal_lockon");

    foreach(var_02 in level.func_A056.targets) {
      if(var_2.func_AEDF.func_AEEA)
        var_02 func_105D6();
    }

    setomnvar("ui_jackal_callouts_enabled", 1);
  }

  if(scripts\engine\utility::player_is_in_jackal())
    level.player _meth_8490("disable_lockon", var_00);
}

func_A066(var_00) {
  if(!isDefined(var_00)) {}

  self.func_862D = var_00;
  self notify("death");
}

func_A0BE(var_00) {
  if(!isDefined(var_00))
    var_00 = 1;

  if(var_00) {
    _setsaveddvar("spaceshipAnalogPhysics", 0);
    level.func_A056.func_2CAD = 400;
  } else {
    _setsaveddvar("spaceshipAnalogPhysics", 1);
    level.func_A056.func_2CAD = 0;
  }

  level.player _meth_8490("auto_boost_on", var_00);
}

func_9CC8() {
  if(isDefined(self.func_AEDF))
    return 1;
  else
    return 0;
}

func_107A2() {
  var_00 = scripts\engine\utility::spawn_tag_origin();
  var_00 func_D2A5();
}

func_D2A5() {
  self.func_4074 = [];
  self.lookahead = scripts\engine\utility::spawn_tag_origin();
  self.lookahead linkto(self, "tag_origin", (2000, 0, 0), (0, 0, 0));
  self.func_BCDA = scripts\engine\utility::spawn_tag_origin();
  self.func_BCDA linkto(self, "tag_origin", (0, 0, 0), (0, 0, 0));
  self.func_B017 = scripts\engine\utility::spawn_tag_origin();
  self.func_B017 linkto(self.lookahead, "tag_origin", (0, 0, 0), (0, 0, 0));
  self.func_4074 = scripts\engine\utility::array_add(self.func_4074, self.func_BCDA);
  self.func_4074 = scripts\engine\utility::array_add(self.func_4074, self.lookahead);
  self.func_4074 = scripts\engine\utility::array_add(self.func_4074, self.func_B017);
  thread func_D29D();
  self.func_CFD9 = spawnStruct();
  self.func_CFD9.func_BC49 = (0, 0, 0);
  self.func_CFD9.func_AFF8 = (0, 0, 0);
  self.func_CFD9.func_1D11 = (0, 0, 0);
  self.func_CFD9.func_11535 = 0;
  self.func_CFD9.func_11533 = 0;
  self.func_CFD9.func_E67D = 0;
  self.func_CFD9.func_B3D1 = 0;
  level.func_D299 = self;
}

func_D29B(var_00, var_01) {
  thread func_D29C(var_00, var_01);
}

func_D29C(var_00, var_01) {
  var_02 = var_01;
  var_03 = self.func_CFD9.func_B3D1;

  while(var_02 > 0) {
    var_04 = scripts\sp\math::func_C097(0, var_01, var_02);
    self.func_CFD9.func_B3D1 = scripts\sp\math::func_6A8E(var_00, var_03, var_04);
    var_02 = var_02 - 0.05;
    wait 0.05;
  }

  self.func_CFD9.func_B3D1 = var_00;
}

func_D2A7() {
  self endon("death");
  func_A38E(35, 3, 0.65, 0.5);
  thread func_D2A4();

  for(;;) {
    self waittill("position_update");
    var_00 = anglesToForward(self.func_114F8);
    var_01 = anglestoright(self.func_114F8);
    var_02 = anglestoup(self.func_114F8);
    var_03 = anglesToForward(self.angles);
    var_04 = anglestoright(self.angles);
    var_05 = anglestoup(self.angles);
    var_06 = scripts\sp\math::func_AB6F(var_03, var_00, self.func_AB72);
    var_07 = scripts\sp\math::func_AB6F(var_04, var_01, self.func_AB72);
    var_08 = scripts\sp\math::func_AB6F(var_05, var_02, self.func_AB72);
    var_09 = distance(self.origin, self.func_1153B);
    var_10 = scripts\sp\math::func_C097(0, self.func_AB78, var_09);
    var_11 = scripts\sp\math::func_6A8E(self.func_AB82, self.func_AB8D, var_10);
    self.origin = scripts\sp\math::func_AB6F(self.origin, self.func_1153B, var_11);
    self.angles = _axistoangles(var_06, var_07, var_08);
    self.func_CFD9 func_D2A2(var_06, var_07, var_08);
    self.func_BCDA unlink();
    self.func_B017 unlink();
    self.func_BCDA.origin = self.origin + self.func_CFD9.func_BC49 * self.func_CFD9.func_B3D1 * self.func_BC68;
    self.func_B017.origin = self.lookahead.origin + self.func_CFD9.func_AFF8 * self.func_CFD9.func_B3D1 * self.func_AFF9;
    var_12 = vectornormalize(self.func_B017.origin - self.func_BCDA.origin);
    self.func_BCDA.angles = _axistoangles(var_12, var_07, var_08) + (0, 0, self.func_CFD9.func_E67D) * self.func_CFD9.func_B3D1;
    self.func_BCDA linkto(self);
    self.func_B017 linkto(self);
  }
}

func_D2A0(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07) {
  if(!isDefined(var_01))
    var_01 = (0, 0, 0);

  if(!isDefined(var_02))
    self.func_AB78 = 1000;
  else
    self.func_AB78 = var_02;

  if(!isDefined(var_03))
    self.func_AB82 = 0.05;
  else
    self.func_AB82 = var_03;

  if(!isDefined(var_04))
    self.func_AB8D = 0.15;
  else
    self.func_AB8D = var_04;

  if(!isDefined(var_05))
    self.func_AB72 = 0.07;
  else
    self.func_AB72 = var_05;

  if(!isDefined(var_06))
    self.func_BC68 = 0.05;

  if(!isDefined(var_07))
    self.func_AFF9 = 1;

  self.func_11512 = var_00;
  self.func_11514 = var_01;
}

func_D29A(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08) {
  self notify("new_follow_blend");
  self endon("new_follow_blend");
  var_09 = var_01;

  if(var_00 != self.func_11512) {
    var_10 = self.func_11512;
    var_11 = var_10 scripts\engine\utility::spawn_tag_origin();
    var_11.angles = var_10.angles;
    self.func_11512 = var_11;
    self.func_2B8E = 1;
  } else {
    var_11 = undefined;
    var_00 = self.func_11512;
    var_10 = self.func_11512;
  }

  if(!isDefined(var_02))
    var_12 = self.func_11514;
  else
    var_12 = var_02;

  if(!isDefined(var_03))
    var_13 = self.func_AB78;
  else
    var_13 = var_03;

  if(!isDefined(var_04))
    var_14 = self.func_AB82;
  else
    var_14 = var_04;

  if(!isDefined(var_05))
    var_15 = self.func_AB8D;
  else
    var_15 = var_05;

  if(!isDefined(var_06))
    var_16 = self.func_AB72;
  else
    var_16 = var_06;

  if(!isDefined(var_07))
    var_17 = self.func_BC68;
  else
    var_17 = var_07;

  if(!isDefined(var_08))
    var_18 = self.func_AFF9;
  else
    var_18 = var_08;

  var_19 = self.func_11514;
  var_20 = self.func_AB78;
  var_21 = self.func_AB82;
  var_22 = self.func_AB8D;
  var_23 = self.func_AB72;
  var_24 = self.func_BC68;
  var_25 = self.func_AFF9;

  for(;;) {
    var_26 = scripts\sp\math::func_C097(0, var_01, var_09);

    if(isDefined(var_11)) {
      self.func_11512 unlink();
      var_27 = anglesToForward(var_10.angles);
      var_28 = anglestoright(var_10.angles);
      var_29 = anglestoup(var_10.angles);
      var_30 = anglesToForward(var_0.angles);
      var_31 = anglestoright(var_0.angles);
      var_32 = anglestoup(var_0.angles);
      var_33 = scripts\sp\math::func_6A8E(var_30, var_27, var_26);
      var_34 = scripts\sp\math::func_6A8E(var_31, var_28, var_26);
      var_35 = scripts\sp\math::func_6A8E(var_32, var_29, var_26);
      self.func_11512.origin = scripts\sp\math::func_6A8E(var_0.origin, var_10.origin, var_26);
      self.func_11512.angles = _axistoangles(var_33, var_34, var_35);
    }

    self.func_11514 = scripts\sp\math::func_6A8E(var_12, var_19, var_26);
    self.func_AB78 = scripts\sp\math::func_6A8E(var_13, var_20, var_26);
    self.func_AB82 = scripts\sp\math::func_6A8E(var_14, var_21, var_26);
    self.func_AB8D = scripts\sp\math::func_6A8E(var_15, var_22, var_26);
    self.func_AB72 = scripts\sp\math::func_6A8E(var_16, var_23, var_26);
    self.func_BC68 = scripts\sp\math::func_6A8E(var_17, var_24, var_26);
    self.func_AFF9 = scripts\sp\math::func_6A8E(var_18, var_25, var_26);

    if(isDefined(var_11))
      self.func_11512 linkto(var_00);

    self notify("target_ent_blend_done");
    wait 0.05;
    var_09 = var_09 - 0.05;

    if(var_26 == 0) {
      break;
    }
  }

  self.func_2B8E = 0;
  func_D2A0(var_00, var_12, var_13, var_14, var_15, var_16, var_17, var_18);
  self notify("target_ent_blend_done");

  if(isDefined(var_11))
    var_11 delete();
}

func_D2A4() {
  self endon("death");

  for(;;) {
    if(isDefined(self.func_11512)) {
      var_00 = anglesToForward(self.func_11512.angles);
      var_01 = anglestoright(self.func_11512.angles);
      var_02 = anglestoup(self.func_11512.angles);
      var_03 = var_00 * self.func_11514[0];
      var_04 = var_01 * self.func_11514[1];
      var_05 = var_02 * self.func_11514[2];
      self.func_1153B = self.func_11512.origin + var_03 + var_04 + var_05;
      self.func_114F8 = _axistoangles(var_00, var_01, var_02);
    } else {
      self.func_1153B = self.origin;
      self.func_114F8 = self.angles;
    }

    self notify("position_update");

    if(isDefined(self.func_2B8E) && self.func_2B8E) {
      self waittill("target_ent_blend_done");
      continue;
    }

    wait 0.05;
  }
}

func_D2A2(var_00, var_01, var_02) {
  var_03 = 160;
  var_04 = 160;
  var_05 = 0.03;
  var_06 = 0.1;
  var_07 = 0.13;
  var_08 = 0.13;
  var_09 = 0.7;
  var_10 = 0.95;
  var_11 = 5500;
  var_12 = -5500;
  var_13 = -5500;
  var_14 = 5500;
  var_15 = level.player getsplashtablename();
  var_15 = var_15 * self.func_B3D1;
  var_16 = level.player getnormalizedmovement();
  var_16 = var_16 * self.func_B3D1;
  self.func_11535 = self.func_11535 + var_15[0] * var_03;
  self.func_11533 = self.func_11533 + var_15[1] * var_04;

  if(self.func_11535 > var_11)
    self.func_11535 = var_11;
  else if(self.func_11535 < var_12)
    self.func_11535 = var_12;

  if(self.func_11533 < var_13)
    self.func_11533 = var_13;
  else if(self.func_11533 > var_14)
    self.func_11533 = var_14;

  self.func_11535 = self.func_11535 * var_09;
  self.func_11533 = self.func_11533 * var_09;
  var_17 = self.func_11535 * var_02 + self.func_11533 * var_01;
  self.func_BC49 = scripts\sp\math::func_AB6F(self.func_BC49, var_17, var_05);
  self.func_AFF8 = scripts\sp\math::func_AB6F(self.func_BC49, var_17, var_06);
  var_18 = (self.func_AFF8[1] - self.func_BC49[1]) * var_08;
  self.func_E67D = scripts\sp\math::func_AB6F(self.func_E67D, var_18, var_07);
  self.func_E67D = self.func_E67D * var_10;
}

func_D29D() {
  self waittill("death");

  foreach(var_01 in self.func_4074) {
    if(isDefined(var_01))
      var_01 delete();
  }
}

func_A105() {
  level.func_D127 func_430E();
}

func_430E() {
  thread func_430F();
}

func_430F() {
  self notify("cockpit_light_change");
  self endon("cockpit_light_change");
  scripts\sp\utility::func_75F8("cockpit_light_side", "tag_cockpit_light_left");
  wait 0.1;
  scripts\sp\utility::func_75F8("cockpit_light_side", "tag_cockpit_light_right");
}

func_A106() {
  level.func_D127 func_4310();
}

func_4310() {
  thread func_4311();
}

func_4311() {
  self notify("cockpit_light_change");
  self endon("cockpit_light_change");
  wait 0.1;
}

func_A110(var_00) {
  if(!isDefined(var_00))
    level.player playSound("jackal_screens_on");

  level.func_D127 func_4323(var_00);
}

func_4323(var_00) {
  if(!isDefined(var_00))
    var_00 = 0;

  setomnvar("ui_jackal_entity", self);
  setomnvar("ui_jackal_cockpit_screens_noboot", var_00);
  setomnvar("ui_jackal_cockpit_screens", 1);

  if(var_00)
    var_01 = "cockpit_light_monitor";
  else
    var_01 = "cockpit_light_monitor_boot";

  func_A108(var_01);
}

func_A108(var_00) {
  if(isDefined(self.func_430D) && self.func_430D == var_00) {
    return;
  }
  func_A109();
  self.func_430D = var_00;
  scripts\sp\utility::func_75C4(self.func_430D + "_l", "tag_cockpit_light_monitor1", undefined, "player_exit_jackal");
  scripts\sp\utility::func_75C4(self.func_430D + "_mid", "tag_cockpit_light_monitor2", undefined, "player_exit_jackal");
  scripts\sp\utility::func_75C4(self.func_430D + "_r", "tag_cockpit_light_monitor3", undefined, "player_exit_jackal");
}

func_A109() {
  if(isDefined(self.func_430D)) {
    scripts\sp\utility::func_75A0(self.func_430D + "_l", "tag_cockpit_light_monitor1", undefined, "player_exit_jackal");
    scripts\sp\utility::func_75A0(self.func_430D + "_mid", "tag_cockpit_light_monitor2", undefined, "player_exit_jackal");
    scripts\sp\utility::func_75A0(self.func_430D + "_r", "tag_cockpit_light_monitor3", undefined, "player_exit_jackal");
  }

  self.func_430D = undefined;
}

func_A10F() {
  level.func_D127 func_4322();
}

func_4322() {
  setomnvar("ui_jackal_cockpit_screens", 0);
  setomnvar("ui_jackal_entity", undefined);
  level.func_D127 func_A109();
}

func_A10C(var_00) {
  level.func_D127.func_4324 = var_00;
  level.func_D127 func_4320(var_00);
}

func_A10A() {
  level.func_D127.func_4324 = undefined;

  if(!isDefined(level.func_D127.func_431C))
    level.func_D127.func_431C = "default";

  level.func_D127 func_4320(level.func_D127.func_431C);
}

func_A10D(var_00, var_01, var_02) {
  level.func_D127 thread func_4321(var_00, var_01, var_02);
}

func_4321(var_00, var_01, var_02) {
  if(isDefined(var_02))
    self notify("cancel_request_for" + var_02);

  self endon("cancel_request_for" + var_00);

  if(isDefined(var_01) && isDefined(self.func_431D)) {
    while(self.func_431D == var_01)
      wait 0.05;
  }

  func_4320(var_00);
}

func_A10B(var_00) {
  level.func_D127.func_431C = var_00;

  if(!isDefined(level.func_D127.func_4324))
    level.func_D127 func_4320(var_00);
}

func_4320(var_00) {
  if(!isDefined(var_00))
    setomnvar("ui_jackal_cockpit_display", 0);

  if(isDefined(self.func_431D) && self.func_431D == var_00) {
    return;
  }
  switch (var_00) {
    case "hand_scanner":
      setomnvar("ui_jackal_cockpit_display", 1);
      func_A108("cockpit_light_monitor");
      break;
    case "damage_alarm":
      setomnvar("ui_jackal_cockpit_display", 2);
      func_A108("cockpit_light_monitor_alarm");
      break;
    case "incoming_missile":
      setomnvar("ui_jackal_cockpit_display", 3);
      func_A108("cockpit_light_monitor_incoming");
      break;
    default:
      setomnvar("ui_jackal_cockpit_display", 0);
      func_A108("cockpit_light_monitor");
  }

  self.func_431D = var_00;
}

func_A10E() {}

func_A261(var_00) {
  if(!isDefined(level.func_D127.func_4B23)) {
    if(isDefined(level.func_D127.func_4B22))
      level.func_D127 stoploopsound(level.func_D127.func_4B22);

    level.func_D127.func_4B22 = var_00;
    level.func_D127 playLoopSound(level.func_D127.func_4B22);
  } else
    level.func_D127.func_4B22 = var_00;
}

func_1100D(var_00) {
  if(isDefined(var_00)) {
    if(isDefined(level.func_D127.func_4B22) && level.func_D127.func_4B22 == var_00) {
      if(!isDefined(level.func_D127.func_4B23))
        level.func_D127 stoploopsound(level.func_D127.func_4B22);

      level.func_D127.func_4B22 = undefined;
    }
  } else {
    if(!isDefined(level.func_D127.func_4B23))
      level.func_D127 stoploopsound(level.func_D127.func_4B22);

    level.func_D127.func_4B22 = undefined;
  }
}

func_A262(var_00) {
  if(isDefined(level.func_D127.func_4B22))
    level.func_D127 stoploopsound(level.func_D127.func_4B22);

  level.func_D127.func_4B23 = var_00;
  level.func_D127 playLoopSound(level.func_D127.func_4B23);
}

func_1100E() {
  if(isDefined(level.func_D127.func_4B23)) {
    level.func_D127 stoploopsound(level.func_D127.func_4B23);
    level.func_D127.func_4B23 = undefined;

    if(isDefined(level.func_D127.func_4B22))
      level.func_D127 playLoopSound(level.func_D127.func_4B22);
  }
}

func_A250(var_00) {
  if(!isDefined(var_00))
    var_00 = 1;

  if(var_00) {
    setomnvar("ui_jackal_atmo_launch", 1);
    setomnvar("ui_jackal_show_horizon", 0);
  } else {
    setomnvar("ui_jackal_atmo_launch", 0);
    setomnvar("ui_jackal_show_horizon", 1);
  }
}

func_A228() {
  level.player notify("jackal_note_hud_on");
  thread func_A229();
}

func_A229() {
  level.player endon("jackal_note_hud_on");
  level.player endon("jackal_note_hud_off");
  level.player scripts\sp\utility::func_65E1("jackal_hud_on");
  setomnvar("ui_hide_hud", 0);
  setomnvar("ui_jackal_bootup", 1);
  setomnvar("ui_jackal_hud_shutdown", 0);
  setomnvar("ui_active_hud", "jackal");

  if(!level.player scripts\sp\utility::func_65DB("disable_jackal_lockon"))
    setomnvar("ui_jackal_callouts_enabled", 1);

  level.func_A056.targets = scripts\engine\utility::array_removeundefined(level.func_A056.targets);
  var_00 = 9;
  var_01 = 0;
}

func_A226(var_00) {
  level.player notify("jackal_note_hud_off");
  thread func_A227(var_00);
}

func_A22A(var_00) {
  thread func_A22B(var_00);
}

func_A22B(var_00) {
  level.player endon("jackal_note_hud_on");
  level.player endon("jackal_note_hud_off");
  setomnvar("ui_jackal_hud_shutdown", 1);
  setomnvar("ui_hide_hud", 1);
  wait 0.5;
  thread func_A226(var_00);
}

func_A227(var_00) {
  level.player scripts\sp\utility::func_65DD("jackal_hud_on");
  setomnvar("ui_jackal_bootup", 0);
  setomnvar("ui_jackal_callouts_enabled", 0);

  if(!isDefined(var_00) || !var_00) {
    setomnvar("ui_hide_hud", 1);
    level.func_A056 waittill("player_left_jackal");
    setomnvar("ui_hide_hud", 0);
    setomnvar("ui_active_hud", "infantry");
  } else
    setomnvar("ui_hide_hud", 1);
}

func_105DB(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07) {
  thread func_11544(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07);
}

func_D920(var_00) {
  self endon("death");

  if(!isDefined(var_00))
    var_00 = "null";

  for(;;)
    wait 0.05;
}

func_11544(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07) {
  self notify("new_target_set");
  self endon("new_target_set");
  self.func_AEDF = spawnStruct();
  self.func_AEDF.targeting = 0;
  self.func_AEDF.func_AF21 = 0;
  self.func_AEDF.locked = 0;
  self.func_AEDF.func_11567 = 0;
  self.func_AEDF.func_2A93 = 0;
  self.func_AEDF.type = var_00;
  self.func_AEDF.priority = 0;
  self.func_AEDF.func_933E = 0;
  self.func_AEDF.func_C35F = 0;
  self.func_AEDF.func_AEEA = 1;
  self.func_AEDF.func_38A4 = 0;
  self.func_AEDF.func_C940 = 0;
  self.func_AEDF.func_72A3 = 0;
  self.func_AEDF.callout = 0;
  self.func_AEDF.func_3A5B = 0;

  if(isDefined(var_02))
    self.func_AEDF.func_3A5C = var_02;
  else
    self.func_AEDF.func_3A5C = "none";

  self.func_AEDF.func_C72C = self.func_AEDF.func_3A5C;

  if(!isDefined(var_03))
    self.func_AEDF.func_3782 = "none";
  else
    self.func_AEDF.func_3782 = var_03;

  if(!isDefined(var_04))
    var_04 = 0;

  if(isDefined(var_06) && var_06)
    var_08 = 0;
  else
    var_08 = 1;

  self _meth_8339(0);
  var_09 = 0;

  if(isDefined(self.script_team)) {
    if(self.script_team == "allies" && isDefined(var_03)) {
      if(!isDefined(var_01)) {
        if(isDefined(self.func_EDB8))
          self.name = self.func_EDB8;
        else
          scripts\sp\names::func_7B07("unitednations");

        var_01 = self.name;
        var_09 = 1;
      }

      func_A32F();
    } else {
      if(!isDefined(var_01))
        var_01 = "JACKAL_ENEMY";

      if(var_00 == "jackal" || var_00 == "ace") {
        self.func_AEDF.func_38A4 = 1;
        self.func_AEDF.func_9405 = 0;
        self.func_AEDF.func_D826 = 0;
      }
    }

    if(isstring(var_01))
      self _meth_8307(var_01, &"");
    else
      self _meth_8307("", var_01);

    if(var_09)
      self.func_AEDF.func_3782 = self.func_AEDF.func_3782 + "_unloc";
  }

  if(isDefined(var_05) && var_05)
    func_A366();

  level.func_A056.targets = scripts\engine\utility::array_removeundefined(level.func_A056.targets);
  level.func_A056.targets = scripts\engine\utility::array_add(level.func_A056.targets, self);
  self _meth_84BE(self.func_AEDF.type);
  func_620B();

  if(var_08)
    thread func_105D7(var_07);
}

func_105D2() {
  thread func_105D4();
}

func_105D4() {
  self endon("death");

  for(;;) {
    while(!isDefined(level.func_D127) || !isDefined(level.func_D127.func_4BC7) || level.func_D127.func_4BC7 != self)
      wait 0.05;

    scripts\sp\utility::func_F40A("enemy", 0, 1);

    while(isDefined(level.func_D127) && isDefined(level.func_D127.func_4BC7) && level.func_D127.func_4BC7 == self)
      wait 0.05;

    self hudoutlinedisable();
  }
}

func_105D3() {
  self endon("stop_highlight_flashes");
  self endon("death");
  var_00 = 3;

  if(isDefined(self.func_A8CB) && gettime() - self.func_A8CB < 10000) {
    if(isDefined(self.func_8EF0)) {
      foreach(var_02 in self.func_8EF0) {
        if(isDefined(var_02))
          self.func_A8CB = gettime();
      }
    } else
      self.func_A8CB = gettime();

    return;
  }

  while(var_00 > 0) {
    if(isDefined(self.func_8EF0)) {
      foreach(var_02 in self.func_8EF0) {
        if(isDefined(var_02)) {
          var_02 scripts\sp\utility::func_F40A("enemy", 0, 1);
          var_2.func_A8CB = gettime();
        }
      }
    } else
      scripts\sp\utility::func_F40A("enemy", 0, 1);

    wait 0.3;

    if(isDefined(self.func_8EF0)) {
      foreach(var_02 in self.func_8EF0) {
        if(isDefined(var_02))
          var_02 hudoutlinedisable();
      }
    } else
      self hudoutlinedisable();

    wait 0.1;
    var_0--;
  }
}

func_A32F() {
  if(self.func_AEDF.func_C940) {
    return;
  }
  self.func_AEDF.func_C941 = 0;
  level.func_A056.func_C93E = scripts\engine\utility::array_removeundefined(level.func_A056.func_C93E);
  level.func_A056.func_C93E = scripts\engine\utility::array_add(level.func_A056.func_C93E, self);
  self.func_AEDF.func_C940 = 1;
}

func_A2DD() {
  if(!self.func_AEDF.func_C940) {
    return;
  }
  level.func_A056.func_C93E = scripts\engine\utility::array_remove(level.func_A056.func_C93E, self);
  self.func_AEDF.func_C940 = 0;
}

func_A36D() {
  if(self.func_AEDF.priority) {
    return;
  }
  level.func_A056.func_D92C = scripts\engine\utility::array_add(level.func_A056.func_D92C, self);
  self.func_AEDF.priority = 1;
  func_0B76::func_F42C(self.func_AEDF.func_3A5C);

  if(self.func_AEDF.func_72A3)
    thread func_3777();
}

func_3777() {
  self endon("death");
  self endon("stop_target_priority");

  for(;;) {
    self _meth_84A0(0);
    wait 0.05;
  }
}

func_A36B() {
  if(self.func_AEDF.func_933E) {
    return;
  }
  level.player playSound("jackal_ui_attacker_warning");
  level.func_A056.func_933B = scripts\engine\utility::array_add(level.func_A056.func_933B, self);
  self.func_AEDF.func_933E = 1;
  self.func_AEDF.func_3A5C = "immediate_threat";
  func_0B76::func_F42C(self.func_AEDF.func_3A5C);
}

func_A36A() {
  if(!self.func_AEDF.priority) {
    return;
  }
  self notify("stop_target_priority");
  level.func_A056.func_D92C = scripts\engine\utility::array_remove(level.func_A056.func_D92C, self);
  self.func_AEDF.priority = 0;
  self.func_AEDF.func_3A5C = self.func_AEDF.func_C72C;
  func_0B76::func_F42C(self.func_AEDF.func_3A5C);

  if(self.func_AEDF.func_72A3)
    func_620A();
}

func_A368() {
  if(!self.func_AEDF.func_933E) {
    return;
  }
  level.func_A056.func_933B = scripts\engine\utility::array_remove(level.func_A056.func_933B, self);
  self.func_AEDF.func_933E = 0;
  self.func_AEDF.func_3A5C = self.func_AEDF.func_C72C;
  func_0B76::func_F42C(self.func_AEDF.func_3A5C);
}

func_A366() {
  if(self.func_AEDF.func_72A3) {
    return;
  }
  self.func_AEDF.func_72A3 = 1;

  if(!self.func_AEDF.priority)
    func_620A();
}

func_A364() {
  if(!self.func_AEDF.func_72A3) {
    return;
  }
  self.func_AEDF.func_72A3 = 0;

  if(!self.func_AEDF.func_11567)
    func_5543();
}

func_620B() {
  func_0B76::func_F42C(self.func_AEDF.func_3A5C);
  self.func_AEDF.func_3A5B = 1;
}

func_E046() {
  self _meth_8558();
  self.func_AEDF.func_3A5B = 0;
}

func_620A() {
  func_0B76::func_F42B(self.func_AEDF.func_3782);
  self.func_AEDF.callout = 1;
}

func_5543() {
  if(!self.func_AEDF.func_72A3) {
    self _meth_84A0(0);
    self.func_AEDF.callout = 0;
  }
}

func_105D7(var_00) {
  self notify("juicy_feedback_thread");
  self endon("Death");
  self endon("spaceship_target_remove");
  self endon("juicy_feedback_thread");

  if(isDefined(var_00))
    var_01 = var_00;
  else
    var_01 = "jackal_impact_target";

  if(self.script_team != "axis") {
    return;
  }
  for(;;) {
    self waittill("damage", var_02, var_03, var_04, var_05, var_06);

    if(!isDefined(self)) {
      return;
    }
    if(isDefined(level.func_D127) && var_03 != level.func_D127) {
      continue;
    }
    if(var_06 == "MOD_PROJECTILE") {
      if(isDefined(level.func_D127) && isDefined(level.func_D127.func_4C15))
        _playworldsound(level.func_D127.func_4C15.func_1151E, var_05);

      var_07 = vectornormalize(var_05 - self.origin);
      playFX(scripts\engine\utility::getfx(var_01), var_05, var_07, (0, 0, 1));
    }
  }
}

func_105DA() {
  func_105D8();
  self.func_AEDF = undefined;
  level.func_A056.targets = scripts\engine\utility::array_remove(level.func_A056.targets, self);
  self _meth_8558();
  self notify("spaceship_target_remove");
}

func_105D8() {
  if(!isDefined(self.func_AEDF)) {}

  self.func_AEDF.func_AEEA = 0;
  func_105D9();
}

func_105D9() {
  if(!isDefined(self.func_AEDF)) {}

  if(self.func_AEDF.func_C940)
    level.func_A056.func_C93E = scripts\engine\utility::array_remove(level.func_A056.func_C93E, self);

  self _meth_84A0(0);
  self _meth_8558();
  self _meth_84C1();
}

func_105D5() {
  if(!isDefined(self.func_AEDF)) {}

  self.func_AEDF.func_AEEA = 1;
  func_105D6();
}

func_105D6() {
  if(level.player scripts\sp\utility::func_65DF("disable_jackal_lockon") && level.player scripts\sp\utility::func_65DB("disable_jackal_lockon")) {
    return;
  }
  if(self.func_AEDF.callout)
    func_0B76::func_F42B(self.func_AEDF.func_3782);

  if(self.func_AEDF.func_C940)
    level.func_A056.func_C93E = scripts\engine\utility::array_add(level.func_A056.func_C93E, self);
  else if(self.func_AEDF.func_3A5B)
    func_0B76::func_F42C(self.func_AEDF.func_3A5C);

  self _meth_84BE(self.func_AEDF.type);
}

func_7B9B() {
  if(scripts\engine\utility::player_is_in_jackal())
    return level.func_D127 gettagorigin("tag_camera");
  else
    return level.player getEye();
}

func_7B9F() {
  if(scripts\engine\utility::player_is_in_jackal())
    return level.func_D127 gettagangles("tag_camera");
  else
    return level.player getEye();
}

func_7BC2() {
  return level.player.func_D409;
}

func_10CD1(var_00, var_01, var_02, var_03) {
  if(!isDefined(var_02))
    var_02 = "fly";

  thread func_10CD4(var_00, var_01, var_02, var_03);
  var_00 func_A287(0.1);
  var_00 scripts\engine\utility::delaythread(0.1, ::func_A2DE, 0);
  var_00 scripts\engine\utility::delaythread(1, ::func_A388, 1);
  func_137D6();

  if(scripts\sp\utility::func_93A6())
    func_0BD9::func_FA4F();
}

func_10CD2(var_00, var_01) {
  thread func_10CD3(var_00, var_01);
}

func_10CD3(var_00, var_01) {
  if(isDefined(var_01)) {
    if(isstring(var_01)) {
      if(_isstruct(scripts\engine\utility::getstruct(var_01, "targetname")))
        var_01 = scripts\engine\utility::getstruct(var_01, "targetname");
      else if(_isent(getent(var_01, "targetname")))
        var_01 = getent(var_01, "targetname");
    }

    var_02 = var_1.origin;

    if(isDefined(var_1.angles))
      var_03 = var_1.angles;
    else
      var_03 = (0, 0, 0);

    var_00 vehicle_teleport(var_02, var_03);
  }

  var_00 func_0BDB::func_A0F7();
  var_00 func_F448("instant");
  level.func_D127 = var_00;
  var_00 func_0BDB::func_BBE0();
  wait 0.1;
  var_00 showallparts();
  var_00 func_0BDB::func_E073(1);
}

func_10CD4(var_00, var_01, var_02, var_03) {
  var_00 thread func_10CD5();

  while(!isDefined(var_0.func_D161))
    wait 0.05;

  var_00 notify("player_jackal_scripting_inited");

  if(var_02 == "runway")
    var_00 func_F48D("runway");
  else if(var_02 == "retribution")
    var_00 func_F48D("retribution");
  else if(var_02 == "shipcrib_europa_launch")
    var_00 func_F48D("shipcrib_europa_launch");
  else
    var_00 func_F48D("instant_" + var_02);

  if(isDefined(var_03))
    var_00 func_F5BD(var_03);
  else if(var_02 == "land")
    var_00 func_F5BD("vtol");
  else if(var_02 == "runway")
    var_00 func_F5BD("runway");
  else if(var_02 == "retribution")
    var_00 func_F5BD("retribution");
  else if(var_02 == "shipcrib")
    var_00 func_F5BD("shipcrib");
  else
    var_00 func_F5BD("instant");

  if(isDefined(var_01)) {
    if(isstring(var_01)) {
      if(_isstruct(scripts\engine\utility::getstruct(var_01, "targetname")))
        var_01 = scripts\engine\utility::getstruct(var_01, "targetname");
      else if(_isent(getent(var_01, "targetname")))
        var_01 = getent(var_01, "targetname");
    }

    var_04 = var_1.origin;

    if(isDefined(var_1.angles))
      var_05 = var_1.angles;
    else
      var_05 = (0, 0, 0);

    var_00 vehicle_teleport(var_04, var_05);
  }

  level.func_D127 = var_00;
  wait 0.05;
  var_00 func_0BDB::func_F51F();
  var_00 func_F48D("default_landed");
  var_00 func_F5BD("vtol");
}

func_10CD5() {
  self endon("player_jackal_scripting_inited");
  wait 2;
}

func_A38E(var_00, var_01, var_02, var_03) {
  if(!isDefined(var_00))
    var_00 = level.func_A056.func_4FEB["spaceshipSpringCameraMaxAngle"];

  if(!isDefined(var_01))
    var_01 = level.func_A056.func_4FEB["spaceshipSpringCameraSpringStrength"];

  if(!isDefined(var_02))
    var_02 = level.func_A056.func_4FEB["spaceshipSpringCameraSpringStrengthOut"];

  if(!isDefined(var_03))
    var_03 = 0;

  thread scripts\sp\utility::func_AB9A("spaceshipSpringCameraMaxAngle", var_00, var_03);
  thread scripts\sp\utility::func_AB9A("spaceshipSpringCameraSpringStrength", var_01, var_03);
  thread scripts\sp\utility::func_AB9A("spaceshipSpringCameraSpringStrengthOut", var_02, var_03);
}

func_A2FC(var_00, var_01, var_02) {
  if(!isDefined(var_02))
    var_02 = "default";

  if(!isDefined(var_01))
    var_01 = 0;

  level.func_A056 thread func_A0CF("boost", var_02, var_00, var_01);
}

func_A303(var_00, var_01) {
  if(!isDefined(var_01))
    var_01 = 0;

  level.func_A056 thread func_A0CF("weapKick", "weapKick", var_00, var_01);
}

func_A2FE(var_00, var_01, var_02) {
  if(!isDefined(var_02))
    var_02 = "default";

  if(!isDefined(var_01))
    var_01 = 0;

  level.func_A056 thread func_A0CF("boost", var_02, var_00, var_01);
}

func_A301(var_00, var_01, var_02) {
  if(!isDefined(var_02))
    var_02 = "default";

  if(!isDefined(var_01))
    var_01 = 0;

  level.func_A056 thread func_A0CF("speed", var_02, var_00, var_01);
}

func_A302(var_00, var_01, var_02) {
  if(!isDefined(var_02))
    var_02 = "default";

  if(!isDefined(var_01))
    var_01 = 0;

  level.func_A056 thread func_A0CF("turn", var_02, var_00, var_01);
}

func_A081(var_00, var_01, var_02, var_03) {
  if(!isDefined(level.func_D127)) {
    return;
  }
  if(!isDefined(var_03)) {
    var_04 = level.func_A056.func_BBB9["view_rotate"] func_7CF7();
    var_03 = "view" + var_04;
  }

  thread func_A082(var_00, var_01, var_02, var_03);
}

func_A082(var_00, var_01, var_02, var_03) {
  level.func_A056 notify("view_rotate" + var_03 + "_impulse");
  level.func_A056 endon("view_rotate" + var_03 + "_impulse");
  level.func_D127 endon("player_left_jackal");
  func_A083(var_00, var_01, var_03);
  wait(var_01);
  func_A083((0, 0, 0), var_02, var_03);
}

func_A07E(var_00, var_01, var_02, var_03) {
  if(!isDefined(level.func_D127)) {
    return;
  }
  if(!isDefined(var_03)) {
    var_04 = level.func_A056.func_BBB9["ship_rotate"] func_7CF7();
    var_03 = "rotate" + var_04;
  }

  thread func_A07F(var_00, var_01, var_02, var_03);
}

func_A07F(var_00, var_01, var_02, var_03) {
  level.func_A056 notify("ship_rotate" + var_03 + "_impulse");
  level.func_A056 endon("ship_rotate" + var_03 + "_impulse");
  level.func_D127 endon("player_left_jackal");
  func_A080(var_00, var_01, var_03);
  wait(var_01);
  func_A080((0, 0, 0), var_02, var_03);
}

func_A079(var_00, var_01, var_02, var_03, var_04) {
  if(!isDefined(level.func_D127)) {
    return;
  }
  var_05 = vectornormalize(level.func_D127.origin - var_00);
  var_06 = var_05 * var_01;

  if(!isDefined(var_04)) {
    var_07 = level.func_A056.func_BBB9["force"] func_7CF7();
    var_04 = "impulse" + var_07;
  }

  thread func_A07A(var_06, var_02, var_03, var_04);
}

func_A07A(var_00, var_01, var_02, var_03) {
  level.func_A056 notify("force" + var_03 + "_impulse");
  level.func_A056 endon("force" + var_03 + "_impulse");
  level.func_D127 endon("player_left_jackal");
  func_A078(var_00, var_01, var_03);
  wait(var_01);
  func_A078((0, 0, 0), var_02, var_03);
}

func_A083(var_00, var_01, var_02) {
  if(!isDefined(var_02))
    var_02 = "default";

  level.func_A056 thread func_A0D0("view_rotate", var_02, var_00, var_01);
}

func_A080(var_00, var_01, var_02) {
  if(!isDefined(var_02))
    var_02 = "default";

  level.func_A056 thread func_A0D0("ship_rotate", var_02, var_00, var_01);
}

func_A078(var_00, var_01, var_02) {
  if(!isDefined(var_02))
    var_02 = "default";

  var_00 = scripts\engine\utility::mph_to_ips(var_00);
  level.func_A056 thread func_A0D0("force", var_02, var_00, var_01);
}

func_A2D7(var_00) {
  if(!isDefined(var_00))
    var_00 = 0.0;

  foreach(var_03, var_02 in level.func_A056.func_BBB9["force"].func_3C66)
  level.func_A056 thread func_A0D0("force", var_03, (0, 0, 0), var_00);
}

func_A0CF(var_00, var_01, var_02, var_03) {
  self notify(var_01);
  self endon(var_01);
  self endon("player_left_jackal");

  if(!isDefined(self.func_BBB9[var_00].func_3C66[var_01]))
    self.func_BBB9[var_00].func_3C66[var_01] = 1;

  var_04 = self.func_BBB9[var_00].func_3C66[var_01] - var_02;

  if(var_03 <= 0.05) {
    self.func_BBB9[var_00].func_3C66[var_01] = var_02;
    return;
  }

  var_05 = var_04 * (1 / (var_03 + 0.05) * 0.05);

  while(var_03 > 0) {
    var_03 = var_03 - 0.05;
    self.func_BBB9[var_00].func_3C66[var_01] = self.func_BBB9[var_00].func_3C66[var_01] - var_05;
    wait 0.05;
  }

  self.func_BBB9[var_00].func_3C66[var_01] = var_02;

  if(self.func_BBB9[var_00].func_3C66[var_01] == 1)
    self.func_BBB9[var_00].func_3C66 = scripts\sp\utility::func_22B2(self.func_BBB9[var_00].func_3C66, var_01);
}

func_7CF7() {
  self.func_1189B++;

  if(self.func_1189B > 100)
    self.func_1189B = 0;

  return self.func_1189B;
}

func_A0D0(var_00, var_01, var_02, var_03) {
  self notify(var_00 + var_01);
  self endon(var_00 + var_01);
  self endon(var_00 + var_01 + "_impulse");
  self endon("player_left_jackal");

  if(!isDefined(self.func_BBB9[var_00].func_3C66[var_01]))
    self.func_BBB9[var_00].func_3C66[var_01] = (0, 0, 0);

  var_04 = self.func_BBB9[var_00].func_3C66[var_01];

  if(var_03 <= 0.05) {
    func_A325(var_00, var_01, var_02);
    return;
  }

  var_05 = var_02 - var_04;
  var_06 = var_05 * (1 / (var_03 + 0.05) * 0.05);

  while(var_03 > 0) {
    var_03 = var_03 - 0.05;
    self.func_BBB9[var_00].func_3C66[var_01] = self.func_BBB9[var_00].func_3C66[var_01] + var_06;
    wait 0.05;
  }

  func_A325(var_00, var_01, var_02);
}

func_A325(var_00, var_01, var_02) {
  if(length(var_02) == 0)
    self.func_BBB9[var_00].func_3C66 = scripts\sp\utility::func_22B3(self.func_BBB9[var_00].func_3C66, [var_01]);
  else
    self.func_BBB9[var_00].func_3C66[var_01] = var_02;
}

func_E0A1() {
  level.func_A056.func_12F96 = scripts\sp\utility::func_22B9(level.func_A056.func_12F96);
  level.func_A056.func_12F96 = scripts\engine\utility::array_removeundefined(level.func_A056.func_12F96);
}

func_137D6() {
  level.player scripts\sp\utility::func_65E3("flag_player_is_flying");
}

func_137CF() {
  level.player endon("death");

  if(isalive(level.player) && level.player scripts\sp\utility::func_65DF("flag_player_has_jackal"))
    level.player scripts\sp\utility::func_65E3("flag_player_has_jackal");
}

func_137DA() {
  for(;;) {
    if(scripts\sp\utility::func_D123()) {
      break;
    }
    wait 0.05;
  }
}

func_137D8() {
  for(;;) {
    var_00 = level.player _meth_8473();

    if(!isDefined(var_00)) {
      break;
    }
    wait 0.05;
  }
}

func_137DB() {
  for(;;) {
    if(func_A2A7())
      return;
    else
      wait 0.05;
  }
}

func_137D9() {
  for(;;) {
    if(!func_A2A7())
      return;
    else
      wait 0.05;
  }
}

func_13797() {
  var_00 = 0;

  for(;;) {
    var_01 = level.player getnormalizedmovement();
    var_02 = var_1[0] + var_1[1];

    if(level.player _meth_8439()) {
      if(var_02 > 0.3 && !var_00) {
        break;
      }
      var_00 = 1;
    } else
      var_00 = 0;

    wait 0.05;
  }
}

func_137A9() {
  if(self.func_99F5.func_BBF1) {
    return;
  }
  for(;;) {
    self waittill("mountable", var_00);

    if(var_00)
      return;
  }
}

waittill_nodialogueplaying() {
  if(!self.func_99F5.func_BBF1) {
    return;
  }
  for(;;) {
    self waittill("mountable", var_00);

    if(!var_00)
      return;
  }
}

func_104A6(var_00) {
  if(var_00 == self.func_99F5.func_BBF1) {
    return;
  }
  self.func_99F5.func_BBF1 = var_00;

  if(var_00) {
    thread func_0BD9::func_1049C();
    self notify("mountable", var_00);
  } else {
    thread func_0BD9::func_1049B();
    self notify("mountable", var_00);
  }
}

func_DE6D() {
  if(self.func_99F5.func_BBF1)
    thread func_0BD9::func_1049C();
}

func_CF50(var_00) {
  func_E0A1();

  foreach(var_02 in level.func_A056.func_12F96)
  var_02 func_104A6(var_00);
}

func_104A0() {
  return isDefined(self.func_1912) && self.func_1912;
}

func_7A5B(var_00) {
  if(scripts\engine\utility::player_is_in_jackal())
    return var_00;
  else
    return var_00 + "_grnd";
}

func_9BDE() {
  if(isDefined(self.classname) && self.classname == "script_vehicle_jackal_fake_enemy")
    return 1;
  else
    return 0;
}

func_9CF5() {
  if(isDefined(self.spawnflags) && self.spawnflags & 1)
    return 1;
  else
    return 0;
}

func_A2A7() {
  if(isDefined(self.owner) && self.owner == level.player)
    return 1;
  else
    return 0;
}

func_13675(var_00) {
  self endon("death");
  self endon("entitydeleted");
  self endon("fakedeath");
  wait(var_00);
}

func_A06A(var_00) {
  level notify("notify_new_landing_state");
  level endon("notify_new_landing_state");

  if(!isDefined(var_00))
    var_00 = 1;

  if(var_00)
    level.player scripts\sp\utility::func_65E1("flag_player_landing_enabled");
  else
    level.player scripts\sp\utility::func_65DD("flag_player_landing_enabled");

  foreach(var_02 in level.func_A056.func_1632) {
    foreach(var_04 in var_2.lights) {
      if(var_00) {
        if(var_2.enabled)
          playFXOnTag(scripts\engine\utility::getfx("landing_pad_lights"), var_04, "tag_origin");

        continue;
      }

      _killfxontag(scripts\engine\utility::getfx("landing_pad_lights"), var_04, "tag_origin");
    }

    if(!var_00)
      var_02 func_0BDB::func_4130();
  }
}

func_A24B(var_00, var_01) {
  if(!isDefined(var_01))
    var_01 = 1;

  var_02 = [];

  foreach(var_04 in level.func_A056.func_A82D) {
    if(isDefined(var_4.script_noteworthy) && var_4.script_noteworthy == var_00)
      var_02 = scripts\engine\utility::array_add(var_02, var_04);
  }

  foreach(var_04 in var_02)
  func_6211(var_04, var_01);
}

func_A24A(var_00) {
  var_01 = [];

  foreach(var_03 in level.func_A056.func_A82D) {
    if(isDefined(var_3.script_noteworthy) && var_3.script_noteworthy == var_00)
      var_01 = scripts\engine\utility::array_add(var_01, var_03);
  }

  foreach(var_03 in var_01) {
    level.func_A056.func_A82D = scripts\engine\utility::array_remove(level.func_A056.func_A82D, var_03);

    if(scripts\engine\utility::array_contains(level.func_A056.func_1632, var_03))
      level.func_A056.func_1632 = scripts\engine\utility::array_remove(level.func_A056.func_1632, var_03);

    var_03 func_0BDB::func_4130();
    var_3.func_1270F delete();

    foreach(var_07 in var_3.lights)
    var_07 delete();
  }
}

func_6211(var_00, var_01) {
  if(var_0.enabled != var_01) {
    var_0.enabled = var_01;

    if(var_01) {
      level.func_A056.func_1632 = scripts\engine\utility::array_add(level.func_A056.func_1632, var_00);
      _objective_add(scripts\sp\utility::func_C264("OBJ_VTOL_LAND"), "invisible");
      objective_onentity(scripts\sp\utility::func_C264("OBJ_VTOL_LAND"), var_0.tag_origin);
      objective_state(scripts\sp\utility::func_C264("OBJ_VTOL_LAND"), "current");
    } else {
      level.func_A056.func_1632 = scripts\engine\utility::array_remove(level.func_A056.func_1632, var_00);
      var_00 func_0BDB::func_4130();
      objective_delete(scripts\sp\utility::func_C264("OBJ_VTOL_LAND"));
    }

    foreach(var_03 in var_0.lights) {
      if(var_01 && level.player scripts\sp\utility::func_65DB("flag_player_landing_enabled")) {
        playFXOnTag(scripts\engine\utility::getfx("landing_pad_lights"), var_03, "tag_origin");
        continue;
      }

      _killfxontag(scripts\engine\utility::getfx("landing_pad_lights"), var_03, "tag_origin");
    }
  }
}

func_137F6(var_00, var_01, var_02, var_03) {
  self endon("entitydeleted");
  var_00 endon("entitydeleted");

  if(!isDefined(var_03))
    var_03 = 0.1;

  var_04 = "waittill_point_timeout";
  var_05 = "point_success";
  self endon(var_04);
  thread func_1358E(var_02, var_04, var_05);

  while(!func_9C87(var_00, var_01))
    wait(var_03);

  self notify(var_05);
}

func_1358E(var_00, var_01, var_02) {
  self endon(var_02);
  wait(var_00);
  self notify(var_01);
}

func_9C87(var_00, var_01) {
  var_02 = undefined;

  if(_isent(var_00) || _isstruct(var_00))
    var_02 = var_0.origin;
  else if(!_isvector(var_00)) {} else
    var_02 = var_00;

  var_03 = vectordot(vectornormalize(var_02 - self.origin), anglesToForward(self.angles));

  if(var_03 > var_01)
    return 1;
  else
    return 0;
}

func_9B92(var_00, var_01) {
  var_02 = undefined;

  if(_isent(var_00) || _isstruct(var_00))
    var_02 = var_0.origin;
  else if(!_isvector(var_00)) {} else
    var_02 = var_00;

  var_03 = distance(self.origin, var_02);

  if(var_03 < var_01)
    return 1;
  else
    return 0;
}

func_1079F(var_00, var_01) {
  var_00 = getent(var_00, "targetname");

  if(!isDefined(var_00)) {}

  var_02 = var_00 scripts\sp\utility::func_10808();

  if(isDefined(var_01))
    var_02 func_1162F(var_01);

  return var_02;
}

func_1162F(var_00) {
  var_01 = scripts\engine\utility::getstruct(var_00, "targetname");

  if(!isDefined(var_01)) {}

  if(!isDefined(var_1.angles))
    var_1.angles = (0, 0, 0);

  self vehicle_teleport(var_1.origin + (0, 0, 70), var_1.angles);
  self _meth_8455(var_1.origin + (0, 0, 70), 1, var_1.angles);
}

func_10749() {
  self.func_BC85 = scripts\engine\utility::spawn_tag_origin();
  self.func_AFEE = scripts\engine\utility::spawn_tag_origin();
  self.func_4074 = scripts\engine\utility::array_combine(self.func_4074, [self.func_BC85, self.func_AFEE]);
}

func_E04B() {
  if(isDefined(self.func_BC85))
    self.func_BC85 delete();

  if(isDefined(self.func_AFEE))
    self.func_AFEE delete();
}

func_7AB7() {
  if(!isDefined(level.func_D127)) {
    return;
  }
  return level.func_D127.func_AFEE;
}

func_7AFB() {
  if(!isDefined(level.func_D127)) {
    return;
  }
  return level.func_D127.func_BC85;
}

func_7B9E() {
  if(!isDefined(level.func_D127))
    return 0;
  else
    return length(level.func_D127.spaceship_vel);
}

func_7B9C() {
  if(!isDefined(level.func_D127))
    return 0;
  else {
    var_00 = rotatevectorinverted(level.func_D127.spaceship_vel, level.func_D127.angles);
    return var_0[0];
  }
}

func_D16C(var_00, var_01, var_02, var_03, var_04, var_05) {
  var_06 = "moveto";
  var_07 = func_7AFB();
  var_07 func_D960(var_00, var_05);
  func_D155(var_07, var_01, var_02, var_03, var_04, var_06);
}

func_D165(var_00, var_01, var_02, var_03, var_04, var_05) {
  var_06 = "lookat";
  var_07 = func_7AB7();
  var_07 func_D960(var_00, var_05);
  func_D155(var_07, var_01, var_02, var_03, var_04, var_06);
}

func_D155(var_00, var_01, var_02, var_03, var_04, var_05) {
  if(isDefined(var_04) && var_04)
    var_06 = "absolute";
  else
    var_06 = "desires";

  level.func_A056.func_11B0D[var_05][var_06] = 1;
  level.func_D127 notify(var_05 + "_started");
  level.player _meth_8462(var_00, var_05, var_06, var_01, var_03);
  level.player _meth_8462(var_00, var_05, var_06 + "_player", var_02, var_03);

  if(var_01 == 0 && var_02 == 1)
    thread func_D156(var_05, var_06, var_03);
}

func_D156(var_00, var_01, var_02) {
  level.func_D127 endon(var_00 + "_started");
  wait(var_02);
  level.func_A056.func_11B0D[var_00][var_01] = 0;

  if(level.func_A056.func_11B0D[var_00]["absolute"] == 0 && level.func_A056.func_11B0D[var_00]["desires"] == 0 && level.func_A056.func_11B0D[var_00]["link"] == 0)
    level.player _meth_8463(var_00);
}

func_D164(var_00, var_01) {
  if(!isDefined(var_01))
    var_01 = 0;

  level.func_A056.func_11B0D["moveto"]["link"] = 1;
  level.func_A056.func_11B0D["lookat"]["link"] = 1;
  level.func_D127 notify("moveto_started");
  level.func_D127 notify("lookat_started");
  level.func_D127 endon("linktoblend_started");
  level.player _meth_8462(var_00, "orient", "time", 1, var_01);
  level.player _meth_8462(var_00, "orient", "time_player", 0, var_01);
  level.player _meth_8462(var_00, "moveto", "time", 1, var_01);
  level.player _meth_8462(var_00, "moveto", "time_player", 0, var_01);
  level.func_A056.func_AD1D = var_00;
}

func_D190(var_00) {
  if(!isDefined(level.func_A056.func_AD1D)) {
    return;
  }
  if(!isDefined(var_00))
    var_00 = 0;

  thread func_D191(var_00, "moveto", "moveto");
  thread func_D191(var_00, "lookat", "orient");
  wait(var_00);
  level.func_A056.func_AD1D = undefined;
}

func_D191(var_00, var_01, var_02) {
  level.func_D127 endon(var_01 + "_started");
  level.func_D127 endon("linktoblend_started");
  level.player _meth_8462(level.func_A056.func_AD1D, var_02, "time", 0, var_00);
  level.player _meth_8462(level.func_A056.func_AD1D, var_02, "time_player", 1, var_00);
  wait(var_00);
  level.func_A056.func_11B0D["moveto"]["link"] = 0;
  level.func_A056.func_11B0D["lookat"]["link"] = 0;

  if(level.func_A056.func_11B0D[var_01]["absolute"] == 0 && level.func_A056.func_11B0D[var_01]["desires"] == 0 && level.func_A056.func_11B0D[var_01]["link"] == 0)
    level.player _meth_8463(var_01);
}

func_D960(var_00, var_01) {
  if(_isvector(var_00)) {
    if(self getteamflagcount())
      self unlink();

    self dontinterpolate();
    self.origin = var_00;
  } else if(_isstruct(var_00)) {
    if(self getteamflagcount())
      self unlink();

    self dontinterpolate();
    self.origin = var_0.origin;
  } else if(_isent(var_00)) {
    if(!isDefined(var_01))
      var_01 = _getpartname(var_0.model, 0);

    self linkto(var_00, var_01, (0, 0, 0), (0, 0, 0));
  } else {}
}

func_A2B0(var_00, var_01, var_02, var_03) {
  if(!isDefined(var_02))
    var_02 = 0.2;

  if(!isDefined(var_03))
    var_03 = 0.2;

  level.player _meth_8489("body", var_00, var_02, var_01);
  wait(getanimlength(var_00) - var_03);
  level.player _meth_8489("blendout", var_00, var_03, var_01);
}

func_2B74(var_00, var_01, var_02, var_03, var_04, var_05) {
  self notify("stop_blended_links");
  self endon("stop_blended_links");

  if(!isDefined(var_03))
    var_03 = 0;

  var_06 = var_02 * var_03;

  if(!isDefined(var_04))
    var_04 = _getpartname(var_0.model, 0);

  if(!isDefined(var_05))
    var_05 = _getpartname(var_1.model, 0);

  while(var_06 < var_02) {
    var_07 = var_06 / var_02;
    var_08 = var_00 gettagangles(var_04);
    var_09 = var_01 gettagangles(var_05);
    var_10 = anglestoaxis(var_08);
    var_11 = anglestoaxis(var_09);
    var_12 = var_11["forward"] * var_07 + var_10["forward"] * (1 - var_07);
    var_13 = var_11["right"] * var_07 + var_10["right"] * (1 - var_07);
    var_14 = var_11["up"] * var_07 + var_10["up"] * (1 - var_07);
    var_15 = _axistoangles(var_12, var_13, var_14);
    var_16 = var_00 gettagorigin(var_04);
    var_17 = var_01 gettagorigin(var_05);
    var_18 = var_17 * var_07 + var_16 * (1 - var_07);

    if(var_07 < 0.5)
      self linkto(var_00, var_04, rotatevectorinverted(var_18 - var_16, var_08), var_15 - var_08);
    else
      self linkto(var_01, var_05, rotatevectorinverted(var_18 - var_17, var_09), var_15 - var_09);

    wait 0.05;
    var_06 = var_06 + 0.05;
  }

  scripts\engine\utility::waitframe();

  if(isDefined(self.start))
    self.start delete();
}

func_13DE7(var_00, var_01) {
  if(var_0[var_01] > 180)
    var_02 = var_0[var_01] - 360;
  else if(var_0[var_01] < -180)
    var_02 = var_0[var_01] + 360;
  else
    var_02 = var_0[var_01];

  return var_02;
}

func_12D71(var_00, var_01, var_02) {
  var_03 = var_0[var_02];
  var_04 = var_1[var_02];

  for(;;) {
    if(var_03 - var_04 > 180) {
      var_03 = var_03 - 360;
      continue;
    }

    if(var_03 - var_04 < -180) {
      var_03 = var_03 + 360;
      continue;
    }

    return var_03;
  }
}

func_C6FC(var_00, var_01, var_02) {
  self.angles = func_1E83(var_0.angles, var_1.angles, var_02);
}

func_1E83(var_00, var_01, var_02) {
  var_03 = anglesToForward(var_01);
  var_04 = anglesToForward(var_00);
  var_05 = anglestoup(var_01);
  var_06 = anglestoup(var_00);
  var_07 = anglestoright(var_01);
  var_08 = anglestoright(var_00);
  var_09 = var_04 * (1 - var_02) + var_03 * var_02;
  var_10 = var_08 * (1 - var_02) + var_07 * var_02;
  var_11 = var_06 * (1 - var_02) + var_05 * var_02;
  return _axistoangles(var_09, var_10, var_11);
}

func_1994(var_00, var_01, var_02, var_03, var_04, var_05) {
  self.var_1198.func_7235.target = var_00;
  self.var_1198.func_7235.offset = var_01;
  self.var_1198.func_7235.func_7237 = 0;
  self notify("bt_state_changed");

  if(isDefined(var_02)) {
    self.var_1198.func_7235.func_98F9 = var_02;
    self.var_1198.func_7235.func_98FE = var_03;
    self.var_1198.func_7235.func_C760 = var_04;
    self.var_1198.func_7235.func_C765 = var_05;
  } else {
    self.var_1198.func_7235.func_98F9 = undefined;
    self.var_1198.func_7235.func_98FE = undefined;
    self.var_1198.func_7235.func_C760 = undefined;
    self.var_1198.func_7235.func_C765 = undefined;
  }
}

func_19B7() {
  self.var_1198.func_7235.target = undefined;
  self.var_1198.func_7235.offset = undefined;
}

func_199D(var_00, var_01, var_02, var_03, var_04, var_05) {
  self notify("new_follow_offset");
  thread func_A254(var_00, var_01, var_02, var_03, var_04, var_05);
}

func_A254(var_00, var_01, var_02, var_03, var_04, var_05) {
  self endon("death");
  self endon("entitydeleted");
  self endon("new_follow_offset");
  var_06 = self.var_1198.func_7235.offset;
  var_07 = self.var_1198.func_7235.func_98F9;
  var_08 = self.var_1198.func_7235.func_98FE;
  var_09 = self.var_1198.func_7235.func_C760;
  var_10 = self.var_1198.func_7235.func_C765;

  for(var_11 = var_00; var_11 > 0; var_11 = var_11 - 0.05) {
    var_12 = var_11 / var_00;
    var_13 = scripts\sp\math::func_6A8E(var_01, var_06, var_12);
    var_14 = scripts\sp\math::func_6A8E(var_02, var_07, var_12);
    var_15 = scripts\sp\math::func_6A8E(var_03, var_08, var_12);
    var_16 = scripts\sp\math::func_6A8E(var_04, var_09, var_12);
    var_17 = scripts\sp\math::func_6A8E(var_05, var_10, var_12);
    func_A255(var_13, var_14, var_15, var_16, var_17);
    wait 0.05;
  }

  func_A255(var_01, var_02, var_03, var_04, var_05);
}

func_A255(var_00, var_01, var_02, var_03, var_04) {
  self.var_1198.func_7235.offset = var_00;
  self.var_1198.func_7235.func_7237 = 0;
  self.var_1198.func_7235.func_98F9 = var_01;
  self.var_1198.func_7235.func_98FE = var_02;
  self.var_1198.func_7235.func_C760 = var_03;
  self.var_1198.func_7235.func_C765 = var_04;
}

func_A372(var_00) {
  var_01 = _getcsplineid(var_00);
  var_02 = getcsplinepointposition(var_01, 0);
  self vehicle_teleport(var_02, self.angles);
  return var_01;
}

func_A373(var_00, var_01) {
  var_02 = func_A372(var_00);
  thread func_A1EF(var_02, var_01);
}

func_A1EF(var_00, var_01, var_02, var_03, var_04) {
  if(!isDefined(var_01)) {
    var_05 = func_1996();
    var_01 = var_5.speed;
  }

  if(!isDefined(var_04))
    var_04 = 1.0;

  if(!isDefined(var_02))
    var_02 = var_04 * scripts\engine\utility::mph_to_ips(var_01);

  func_A1ED(var_00, var_01, var_02, var_03);
  func_A342(var_00, var_04, var_03);
}

func_A1F3(var_00, var_01, var_02, var_03, var_04) {
  if(!isDefined(var_04))
    var_04 = 1.0;

  if(!isDefined(var_03))
    var_03 = 2048;

  func_A1F2(var_00, var_01, var_02, var_03);
  func_A342(var_00, var_04, 1);
}

func_A1F0(var_00, var_01, var_02, var_03, var_04) {
  func_1981();

  if(!isDefined(var_03))
    var_03 = 0.2;

  var_05 = _getcsplineid(var_00);
  var_06 = (var_04, 0, 0);
  var_06 = rotatevector(var_06, self.angles);
  var_07 = self.origin + var_06;
  var_08 = _calccsplineclosestpoint(var_05, var_07);
  self _meth_8455(var_08);

  if(!isDefined(var_02))
    var_02 = 384.0;

  self setneargoalnotifydist(var_02);

  if(isDefined(var_01))
    self _meth_845F(var_01);

  self waittill("near_goal");
  func_1981();
  self _meth_8479(var_05);
  self _meth_847B(var_03, var_07);
  self.func_10A43 = var_05;
  self waittill("near_goal");
  func_0C24::func_10A44(var_05);
}

func_A1ED(var_00, var_01, var_02, var_03) {
  if(isDefined(self.var_1198))
    func_1981();

  if(isDefined(var_03) && var_03)
    var_04 = _calccsplineclosestpoint(var_00, self.origin);
  else
    var_04 = getcsplinepointposition(var_00, 0);

  self _meth_8455(var_04);

  if(!isDefined(var_02))
    var_02 = 384.0;

  self setneargoalnotifydist(var_02);

  if(isDefined(var_01))
    self _meth_845F(var_01);

  self waittill("near_goal");
}

func_A1F2(var_00, var_01, var_02, var_03) {
  if(isDefined(self.var_1198))
    func_1981();

  var_04 = getcsplinepointposition(var_00, var_01);
  self _meth_8455(var_04);

  if(!isDefined(var_03))
    var_03 = 384.0;

  self setneargoalnotifydist(var_03);

  if(isDefined(var_02))
    self _meth_845F(var_02);

  self waittill("near_goal");
}

func_A112(var_00, var_01, var_02, var_03) {
  thread func_A113(var_00, var_01, var_02, var_03);
}

func_A113(var_00, var_01, var_02, var_03) {
  if(isDefined(level.func_D127.func_5F6F)) {
    return;
  }
  if(!isDefined(var_01))
    var_01 = 3;

  if(!isDefined(var_02))
    var_02 = 0;

  if(!isDefined(var_03))
    var_03 = 0.5;

  var_04 = [var_02, var_00, var_01, gettime(), var_03];
  func_A104(var_04);

  if(!isDefined(level.func_D127.func_432D))
    thread func_A115();
}

func_A115() {
  level.func_D127.func_432D = scripts\engine\utility::spawn_script_origin();
  level.func_D127.func_432D linkto(level.func_D127, "tag_origin", (0, 0, 0), (0, 0, 0));

  while(level.func_A056.func_432C.size > 0) {
    var_00 = level.func_A056.func_432C[0];
    level.func_A056.func_432C = scripts\sp\utility::array_remove_index(level.func_A056.func_432C, 0);
    level.player scripts\sp\utility::func_65E8("disable_jackal_cockpit_VO");

    if(gettime() - var_0[3] > var_0[2] * 1000) {
      continue;
    }
    level.player scripts\sp\utility::func_65E1("jackal_cockpit_VO");
    level.func_A056.func_4B57 = var_0[0];
    level.func_D127.func_432D func_A114(var_0[1]);
    level.player scripts\sp\utility::func_65DD("jackal_cockpit_VO");
    level.func_A056.func_4B57 = -999999;

    if(level.func_A056.func_432C.size > 0)
      wait(level.func_A056.func_432C[0][4]);
  }

  level.func_D127.func_432D delete();
}

func_A114(var_00) {
  self endon("jackal_cockpit_VO_interupt");
  self playSound(var_00, "sounddone");
  self waittill("sounddone");
}

func_A104(var_00) {
  var_01 = 0;

  for(;;) {
    if(level.func_A056.func_432C.size == var_01) {
      level.func_A056.func_432C[var_01] = var_00;
      break;
    }

    if(var_0[0] > level.func_A056.func_432C[var_01][0]) {
      level.func_A056.func_432C = scripts\engine\utility::array_insert(level.func_A056.func_432C, var_00, var_01);
      break;
    }

    var_1++;
  }
}

func_199B() {
  thread func_199C();
}

func_199C() {
  self endon("dont_kill_when_stuck");
  self waittill("jackal_stuck_on_geo");
  self notify("death");
}

func_198D() {
  self notify("dont_kill_when_stuck");
}

func_A1F4(var_00, var_01, var_02, var_03) {
  var_04 = scripts\engine\utility::getstruct(var_00, "targetname");

  if(isDefined(var_03) && var_03)
    var_05 = var_4.angles;
  else
    var_05 = undefined;

  func_A1EC(var_4.origin, var_01, var_02, var_05);
}

func_A1EC(var_00, var_01, var_02, var_03) {
  self endon("death");
  self endon("delete");

  if(!isDefined(var_02))
    var_02 = 384.0;

  func_1981();

  if(isDefined(var_03))
    self _meth_8455(var_00, var_01, var_03);
  else
    self _meth_8455(var_00, var_01);

  self setneargoalnotifydist(var_02);

  if(var_01)
    self waittill("goal");
  else
    self waittill("near_goal");
}

func_1981() {
  if(!isDefined(self.var_1198)) {
    return;
  }
  if(self.var_1198.func_EF72 && !isDefined(self.func_1FCE)) {
    return;
  }
  if(!self.var_1198.func_EF72)
    self.func_1FCE = 1;

  self.var_1198.func_3F28 = undefined;
  self notify("jackal_animscripteduntilgoal");
  func_19A9();
  thread func_1982();
}

func_1982() {
  self endon("jackal_animscripteduntilgoal");
  self waittill("near_goal");
  func_1988();
  self.func_1FCE = undefined;
}

func_19A9() {
  self.var_1198.func_EF72 = 1;
  self.var_3135.func_3F28 = undefined;
}

func_1988() {
  self.var_1198.func_EF72 = 0;
}

func_19A2() {
  scripts\asm\asm_bb::bb_setanimscripted();
  func_19A9();
}

func_1986() {
  scripts\asm\asm_bb::bb_clearanimscripted();
  func_1988();
}

func_19B1(var_00) {
  self.var_1198.func_90EA = var_00;
}

func_19B0(var_00) {
  self.var_1198.func_E1AC = var_00;

  if(var_00 == "hover" || var_00 == "fly") {
    self _meth_8491(var_00);
    func_0C21::func_20DD();
  }
}

func_1984(var_00) {
  func_19B5(var_00);
  func_1980(0.5);
  wait 0.05;
  func_19AE("shoot_single_burst");
  self waittill("firemode changed");
  func_198A();
  func_1980();
}

func_6E8C(var_00) {
  if(isDefined(level.func_D127) && var_00 == level.func_D127)
    thread func_6E92();

  scripts\engine\utility::waittill_either("missile_hit", "burnt_out");
  self.active = 0;
  self notify("pos_updated");
  stopFXOnTag(self.fx, self, "tag_origin");

  if(isDefined(var_00) && scripts\engine\utility::array_contains(var_0.func_6E9C.func_12B86, self))
    var_0.func_6E9C.func_12B86 = scripts\engine\utility::array_remove(var_0.func_6E9C.func_12B86, self);

  wait 0.05;
  self delete();
}

func_6E92() {
  self endon("burnt_out");
  self waittill("missile_hit");
  self playSound("jackal_flare_hit_missile");
}

func_19AF(var_00, var_01, var_02) {
  if(!isDefined(self.func_6E9C)) {
    return;
  }
  if(isDefined(var_00)) {
    var_00 = clamp(var_00, 0, 100);
    self.func_6E9C.func_3C37 = var_00;
  }

  if(isDefined(var_01)) {
    var_01 = clamp(var_01, 0, 100);
    self.func_6E9C.func_3C38 = var_01;
  }

  if(isDefined(var_02)) {
    var_02 = clamp(var_02, 0, 100);
    self.func_6E9C.func_3C36 = var_02;
  }
}

func_19AE(var_00) {
  if(self.var_1198.func_6D77 == var_00) {
    return;
  }
  self.var_1198.func_6D77 = var_00;
  self notify("stop sound" + self.var_1198.func_6D83);
  self notify("firemode changed");

  if(scripts\sp\utility::func_65DF("jackal_firing"))
    scripts\sp\utility::func_65DD("jackal_firing");
}

func_1989() {
  self.var_1198.func_C705 = undefined;
  self.var_1198.func_C702 = undefined;
}

func_19B2(var_00, var_01) {
  self.var_1198.func_C705 = var_00;

  if(var_00 == "face angle") {
    self.var_1198.func_C702 = var_01;
    self goon_spawners(var_00, var_01);
    return;
  }

  self.var_1198.func_C702 = undefined;
  self goon_spawners(var_00);
}

func_19B5(var_00) {
  self.var_1198.func_11577 = var_00;
  func_0C1B::func_12E3A();
}

func_198A() {
  self.var_1198.func_11577 = undefined;
}

func_19A0(var_00) {
  if(!isDefined(var_00))
    var_00 = 1;

  if(var_00)
    func_19A2();
  else
    func_1986();
}

func_19AB(var_00, var_01, var_02, var_03) {
  if(isDefined(self.var_1198)) {
    func_19AD(var_00, var_01, var_02, var_03);
    func_19AC(var_00, var_01, var_02, var_03);
  } else
    self _meth_845F(var_00, var_01, var_02, var_03);
}

func_19AC(var_00, var_01, var_02, var_03) {
  if(!isDefined(var_00))
    self.var_1198.func_23A4 = func_0C21::func_9536();
  else {
    self.var_1198.func_23A4.speed = var_00;

    if(isDefined(var_01))
      self.var_1198.func_23A4.func_1545 = var_01;

    if(isDefined(var_02))
      self.var_1198.func_23A4.func_1E91 = var_02;

    if(isDefined(var_03))
      self.var_1198.func_23A4.func_1E71 = var_03;
  }

  func_0C21::func_20DD();
}

func_19AD(var_00, var_01, var_02, var_03) {
  if(!isDefined(var_00))
    self.var_1198.func_1113B = func_0C21::func_976D();
  else {
    self.var_1198.func_1113B.speed = var_00;

    if(isDefined(var_01))
      self.var_1198.func_1113B.func_1545 = var_01;

    if(isDefined(var_02))
      self.var_1198.func_1113B.func_1E91 = var_02;

    if(isDefined(var_03))
      self.var_1198.func_1113B.func_1E71 = var_03;
  }

  func_0C21::func_20DD();
}

func_1996() {
  return func_0C21::_meth_814A();
}

func_ACE8(var_00, var_01) {
  while(!isDefined(level.func_D127))
    wait 0.05;

  if(!isDefined(var_00))
    var_00 = (1, 1, 1);

  self endon("stop_line");

  for(;;) {
    if(!isDefined(self)) {
      break;
    }
    if(isDefined(var_01))
      var_02 = self gettagorigin(var_01);
    else
      var_02 = self.origin;

    wait 0.05;
  }
}

func_19A7(var_00, var_01, var_02, var_03) {
  if(!isDefined(self.func_B8AE))
    self.func_B8AE = spawnStruct();

  var_00 = max(512, var_00);
  self.func_B8AE.func_DCCA = var_00;
  self.func_B8AE.func_B48B = var_01;
  self.func_B8AE.func_B758 = var_02;

  if(isDefined(var_03))
    self.func_B8AE.func_B4C9 = var_03;
}

func_1987() {
  self.func_B8AE = undefined;
}

func_19A3(var_00) {
  self.var_1198.func_E1AB = var_00;
}

func_1995(var_00) {
  self.var_1198.func_E1AB = var_00;
  self.var_1198.func_38DC = var_00;
  var_01 = undefined;

  if(var_00 == "up")
    var_01 = _func_2EE(self.asmname, "cannon_state", "up", 0);
  else
    var_01 = _func_2EE(self.asmname, "cannon_state", "down", 0);

  self give_left_powers("cannon", var_1.anims, 1.0, 0.0, 1.0);
  self _meth_82B0(var_1.anims, 1.0);
}

func_DBDC(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07) {
  var_08 = scripts\engine\utility::ter_op(isDefined(var_03), var_03, 30000);
  var_09 = distance(level.func_D127.origin, var_00);

  if(var_09 > var_08) {
    return;
  }
  if(isDefined(level.func_58DB)) {
    return;
  }
  level.func_58DB = 1;
  var_10["r_mbenable"] = getdvar("r_mbenable");
  var_10["r_mbRadialOverridePosition"] = getdvar("r_mbRadialOverridePosition");
  var_10["r_mbRadialOverridePositionActive"] = getdvarint("r_mbRadialOverridePositionActive");
  var_10["r_mbradialoverridestrength"] = getdvarfloat("r_mbradialoverridestrength");
  var_10["r_mbradialoverrideradius"] = getdvarfloat("r_mbradialoverrideradius");
  _setsaveddvar("r_mbenable", 1);
  _setsaveddvar("r_mbRadialOverridePosition", var_00);
  _setsaveddvar("r_mbRadialOverridePositionActive", 1);
  var_11 = scripts\engine\utility::ter_op(isDefined(var_02), var_02, 2000);
  var_01 = scripts\engine\utility::ter_op(isDefined(var_01), var_01, 0.135848);
  var_12 = var_01 / 4;
  var_04 = scripts\engine\utility::ter_op(isDefined(var_04), var_04, -0.107266);
  var_05 = scripts\engine\utility::ter_op(isDefined(var_05), var_05, 0.05);
  var_06 = scripts\engine\utility::ter_op(isDefined(var_06), var_06, 0.5);
  var_09 = distance(level.player.origin, var_00);
  var_13 = scripts\sp\math::func_C097(var_08, var_11, var_09);
  var_14 = scripts\sp\math::func_6A8E(var_01, var_12, var_13);
  var_14 = clamp(var_14, 0, 1);

  if(!isDefined(var_07)) {
    if(!scripts\engine\trace::ray_trace_passed(var_00 + (0, 0, 12), level.player getEye())) {
      var_14 = var_14 * 0.5;
      var_14 = clamp(var_14, 0, 1);
    }
  }

  _setsaveddvar("r_mbradialoverridestrength", var_14);
  _setsaveddvar("r_mbradialoverrideradius", var_04);
  wait(var_05);
  thread scripts\sp\utility::func_AB9A("r_mbradialoverridestrength", var_10["r_mbradialoverridestrength"], var_06);
  thread scripts\sp\utility::func_AB9A("r_mbradialoverrideradius", var_10["r_mbradialoverrideradius"], var_06);
  scripts\engine\utility::flag_wait_or_timeout("frag_force_delete", var_06);
  _setsaveddvar("r_mbenable", var_10["r_mbenable"]);
  _setsaveddvar("r_mbRadialOverridePosition", var_10["r_mbRadialOverridePosition"]);
  _setsaveddvar("r_mbRadialOverridePositionActive", var_10["r_mbRadialOverridePositionActive"]);
  level.func_58DB = undefined;
}

func_D527(var_00, var_01, var_02, var_03, var_04) {
  var_05 = spawn("script_origin", var_01);
  var_05 playSound(var_00, "sounddone");

  if(isDefined(var_02))
    var_05 _meth_8277(var_02, 0);

  if(isDefined(var_03))
    var_05 ghostattack(var_03, 0);

  if(isDefined(var_04))
    var_05 linkto(var_04);

  var_05 waittill("sounddone");
  var_05 delete();
}

func_D52C(var_00, var_01, var_02, var_03, var_04, var_05) {
  var_06 = scripts\engine\utility::spawn_tag_origin(self.origin, self.angles);

  if(!isDefined(var_01))
    var_01 = _getpartname(self.model, 0);

  var_06 linkto(self, var_01, (0, 0, 0), (0, 0, 0));
  var_06 playSound(var_00, "sounddone");

  if(isDefined(var_02))
    var_06 _meth_8277(var_02, 0);

  if(isDefined(var_03))
    var_06 ghostattack(var_03, 0);

  if(isDefined(var_04))
    func_D52D(var_06, "sounddone", var_04);
  else
    var_06 waittill("sounddone");

  if(isDefined(var_05))
    wait(var_05);

  var_06 ghostattack(0, 0.1);
  var_06 delete();
}

func_D52D(var_00, var_01, var_02) {
  var_00 endon(var_01);
  self waittill(var_02);
  return;
}

func_F2FF() {
  self _meth_84BF(1);
  level.func_A056.func_D824 = scripts\engine\utility::array_add(level.func_A056.func_D824, self);
  thread func_413C();
  level.player _meth_84D4(1);
}

func_413B() {
  if(isDefined(self)) {
    self _meth_84BF(0);
    level.func_A056.func_D824 = scripts\engine\utility::array_remove(level.func_A056.func_D824, self);
  }

  level.func_A056.func_D824 = scripts\engine\utility::array_removeundefined(level.func_A056.func_D824);

  if(level.func_A056.func_D824.size == 0)
    level.player _meth_84D4(0);
}

func_413C() {
  self waittill("entitydeleted ");
  func_413B();
}

func_A287(var_00) {
  if(isDefined(var_00)) {
    if(isDefined(level.script) && level.script == "moonjackal")
      level.player scripts\engine\utility::delaycall(1, ::_meth_82C0, "jackal_mute_engines", 1);
    else
      level.player _meth_82C0("jackal_mute_engines", var_00);
  } else
    level.player _meth_82C0("jackal_mute_engines", 0.5);
}

func_A388(var_00) {
  if(isDefined(var_00)) {
    if(isDefined(level.script) && level.script == "moonjackal")
      level.player scripts\engine\utility::delaycall(2, ::_meth_82C0, "jackal_cockpit", 0.5);
    else
      level.player _meth_82C0("jackal_cockpit", var_00);
  } else
    level.player _meth_82C0("jackal_cockpit", 0.5);
}

func_1990(var_00) {
  self.var_1198.func_C97C = var_00;
}

func_198E(var_00) {
  self.var_1198.func_0039 = var_00;
}

func_19A1() {
  self.var_3135.func_EF78 = 1;
}

func_198B(var_00) {
  self.func_38A2 = 0;
  thread func_198C(var_00);
}

func_198C(var_00) {
  self notify("cooldown_events_think");
  self endon("cooldown_events_think");
  self endon("death");
  wait(var_00);
  self.func_38A2 = 1;
}

func_3819() {
  if(!self.func_38A2)
    return 0;

  if(self.ignoreme)
    return 0;

  if(func_9CB2())
    return 0;

  if(func_9B67())
    return 0;

  return 1;
}

func_9BCF() {
  if(isDefined(self.var_1198) && isDefined(self.var_1198.func_A421))
    return 1;

  if(isDefined(self.func_A420) && self.func_A420.size > 0)
    return 1;

  return 0;
}

func_9CB2() {
  if(isDefined(self.var_1198) && self.var_1198.func_EF72)
    return 1;
  else
    return 0;
}

func_9B67() {
  if(isDefined(self.var_1198) && self.var_1198.animscriptedactive)
    return 1;
  else
    return 0;
}

func_9C06() {
  if(isDefined(self.var_1198) && isDefined(self.var_1198.func_90EE))
    return 1;
  else
    return 0;
}

func_16EE(var_00, var_01) {
  var_02 = level.func_90E2.func_5084.size;
  level.func_90E2.func_5084[var_02] = var_00;
  level.func_90E2.func_508A[var_02] = var_01;
}

func_A224(var_00, var_01) {
  if(!isDefined(var_00))
    var_00 = 1;

  if(!isDefined(var_01))
    var_01 = 0;

  if(var_00) {
    setomnvar("ui_jackal_autopilot", 1);

    if(var_01)
      func_A112("jackal_hud_autopilot");
  } else
    setomnvar("ui_jackal_autopilot", 0);
}

func_9641() {
  level.func_A056.trigger_func = spawnStruct();
  level.func_A056.trigger_func.func_A0E5 = ::func_A0E5;
  level.func_A056.trigger_func.func_A0E2 = ::func_A0E2;
  level.func_A056.trigger_func.func_A0E3 = ::func_A0E3;
  level.func_A056.trigger_func.func_A0E1 = ::func_A0E1;
}

func_A0E1(var_00, var_01, var_02, var_03) {
  scripts\engine\utility::flag_set(var_03);
  level.func_D127 endon("death");
  level notify("jackal_autoturn");
  level endon("jackal_autoturn");
  func_A1DD("fly");
  func_A1DC(400);
  func_A14A();
  func_A155();
  var_04 = -1;
  func_D165(self.origin, 0, 1, 0);
  func_D16C(self.origin, 0, 1, 0, 1);
  _setsaveddvar("spaceshipautolevel", 2);
  func_A224();
  var_05 = 0;
  wait 0.05;
  var_06 = 150;
  var_07 = 450;
  var_08 = 150;
  var_09 = 0.9;
  func_D165(self.origin, 1, 0, 0.5);
  func_D16C(self.origin, 0.05, 1, 1, 1);
  func_A302(5.5, 0.5, "boundary_autoturn");

  while(scripts\engine\utility::flag(var_02) || var_04 < 0.6) {
    if(!isDefined(level.func_D127)) {
      break;
    }
    var_10 = anglesToForward(level.func_D127.angles);
    var_11 = vectornormalize(self.origin - level.func_D127.origin);
    var_04 = vectordot(var_10, var_11);
    var_12 = length(level.func_D127.spaceship_vel);
    var_13 = scripts\sp\math::func_C097(-1, 1, var_04);
    var_14 = scripts\sp\math::func_6A8E(var_06, var_07, var_13);
    var_15 = var_14 - var_12;
    var_16 = scripts\sp\math::func_C097(-1 * var_08, var_08, var_15);
    var_17 = scripts\sp\math::func_6A8E(1 - var_09, 1 + var_09, var_16);
    func_A301(var_17, 0.05, "boundary_autoturn");

    if(var_04 > 0.4 && !var_05) {
      _setsaveddvar("spaceshipautolevel", 0);
      var_05 = 1;
      func_A302(1, 1, "boundary_autoturn");
    }

    wait 0.05;
  }

  _setsaveddvar("spaceshipautolevel", 0);
  func_A224(0);
  func_A1DD(0);
  func_A1DC(0);
  func_A14A(0);
  func_A155(0);
  func_D165(self.origin, 0, 1, 0.3);
  func_D16C(self.origin, 0, 1, 0.3, 1);
  func_A302(1, 0.2, "boundary_autoturn");
  scripts\engine\utility::flag_clear(var_03);
}

func_A0E5(var_00) {
  if(var_00 && !self.func_138F0) {
    setomnvar("ui_jackal_boundary_warning", 1);
    self.script_team = "allies";
    func_105DB("capitalship", undefined, "none", "none", 0);
    thread func_A0E6();
    thread func_A0E9();
    self.func_138F0 = 1;
  } else if(!var_00 && self.func_138F0) {
    setomnvar("ui_jackal_boundary_warning", 0);
    level notify("stop_boundary_warning_alarm");
    func_0B76::func_F42C("none");
    func_105DA();
    self.func_138F0 = 0;
  }
}

func_A0E2() {
  self endon("stop_trigger_push");

  for(;;) {
    func_A14E(1);

    if(!scripts\engine\utility::player_is_in_jackal() || level.player scripts\sp\utility::func_65DB("disable_jackal_map_boundary_push")) {
      func_A078((0, 0, 0), 0.05, "boundary_push" + self.func_12751);
      wait 0.05;
      continue;
    }

    var_00 = vectornormalize(self.func_98F5.origin - self.func_C75B.origin);
    var_01 = vectornormalize(self.func_C75B.origin - self.func_98F5.origin);
    var_02 = vectornormalize(level.func_D127.origin - self.func_98F5.origin);
    var_03 = vectornormalize(level.func_D127.origin - self.func_C75B.origin);
    var_04 = vectordot(var_02, var_01);
    var_05 = vectordot(var_03, var_00);
    var_04 = clamp(var_04, 0, 1);
    var_05 = clamp(var_05, 0, 1);
    var_06 = 1 - scripts\sp\math::func_C097(0, var_04 + var_05, var_05);
    var_07 = scripts\sp\math::func_6A8E(0, self.func_EEBF, var_06);
    var_07 = var_07 * var_00;
    func_A078(var_07, 0.05, "boundary_push" + self.func_12751);
    wait 0.05;
  }
}

func_A0E3() {
  func_A14E(0);

  if(!scripts\engine\utility::player_is_in_jackal()) {
    return;
  }
  func_A078((0, 0, 0), 0.05, "boundary_push" + self.func_12751);
  self notify("stop_trigger_push");
}

func_A0E6() {
  level endon("stop_boundary_warning_alarm");

  for(;;) {
    thread func_A0E7();
    wait 2.5;
  }
}

func_A0E9() {
  level endon("stop_boundary_warning_alarm");

  for(;;) {
    self _meth_8557("OFFSCREEN_ENEMY_INDICATOR");
    wait 0.5;
    self _meth_8558();
    wait 0.25;
  }
}

func_A0E7() {
  var_00 = spawn("script_origin", level.func_D127.origin);
  var_00 playSound("jackal_boundary_warning", "sounddone");
  var_00 func_A0E8();
  var_00 stopsounds();
  wait 0.05;
  var_00 delete();
}

func_A0E8() {
  level endon("stop_boundary_warning_alarm");
  self waittill("sounddone");
}

func_1997() {
  func_19B1(0);
  func_19AF(100, 100, 100);
  self.func_6E9C.func_50D1 = 0.1;
  self.func_6E9C.func_50D0 = 0.2;
  self.ignoreme = 1;
  self.maxhealth = int(self.maxhealth * 1.5);
  self.health = self.maxhealth;
}

func_1999() {
  func_19B1(0);
  func_19AF(100, 100, 100);
  self.func_6E9C.func_50D1 = 0.4;
  self.func_6E9C.func_50D0 = 0.5;
  self.ignoreme = 1;
  self.maxhealth = int(self.maxhealth * 1.5);
  self.health = self.maxhealth;
}

func_A064(var_00) {
  var_01 = 0;

  for(;;) {
    var_02 = tablelookupbyrow("sp\mostwanted.csv", var_01, 10);

    if(!isDefined(var_02) || var_02 == "") {
      break;
    }
    if(var_02 == var_00) {
      var_03 = tablelookupbyrow("sp\mostwanted.csv", var_01, 2);
      return var_03;
    }

    var_1++;
  }

  return undefined;
}

func_A063() {
  self waittill("death");
  func_0A2F::func_DA45(self.func_92BD);
}

func_1998() {
  func_19AF(100, 100, 100);
  self.func_6E9C.func_50D1 = 0.4;
  self.func_6E9C.func_50D0 = 0.5;
  self.func_51E6 = 1;
}

func_136A6(var_00) {
  self endon("death");

  for(;;) {
    self waittill("trigger", var_01);

    if(!isDefined(var_00) || var_01 != var_00) {
      continue;
    }
    break;
  }
}

func_116A8(var_00, var_01, var_02) {
  if(!isDefined(var_02))
    var_02 = 0;

  var_03 = scripts\sp\hud_util::func_48B7("black", 0, level.player);
  var_04 = scripts\sp\hud_util::createfontstring("default", 1.5);
  var_4.location = 0;
  var_4.alignx = "left";
  var_4.aligny = "top";
  var_4.foreground = 1;
  var_4.sort = 20;
  var_4.alpha = 0;
  var_05 = 0.3;
  var_04 fadeovertime(var_05);
  var_03 fadeovertime(var_05);
  var_3.alpha = 0.7;
  var_4.alpha = 1;
  var_4.x = 40;
  var_4.y = 200 + var_02;
  var_4.label = " " + var_00;
  var_4.color = (1, 1, 1);
  wait(var_01);
  var_05 = 0.5;
  var_04 fadeovertime(var_05);
  var_03 fadeovertime(var_05);
  var_3.alpha = 0.0;
  var_4.alpha = 0;
  wait(var_05);
  var_04 destroy();
  var_03 destroy();
}