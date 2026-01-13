/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3036.gsc
**************************************/

func_A2A8(var_0, var_1, var_2, var_3) {
  func_490C(var_0, var_1);
  var_4 = scripts\engine\utility::ter_op(isDefined(var_3), "tag_pip_copilot", "tag_pip");
  thread func_19CF(var_4);
  scripts\sp\pip_util::func_CBB5(self, var_4, 42);
  level.var_CB9C.clipdistance = 2500;
  thread func_A2AA();
  setomnvar("ui_pip_message_text_bottom", "script_empty_string");
  setomnvar("ui_pip_message_text_top", "jackal_pip_top");
  setomnvar("ui_pip_message_type", 1);

  if(isDefined(var_2)) {
    wait 0.65;
    var_0 scripts\sp\utility::func_10347(var_2);
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

func_F435(var_0) {
  level.var_A056.var_A7EA = var_0;
}

func_16FF(var_0) {
  level.var_A056.var_A7E8 = scripts\engine\utility::array_combine(level.var_A056.var_A7E8, var_0);
}

func_F434(var_0) {
  level.var_A056.var_A7E9 = var_0;
}

func_D803(var_0, var_1) {
  if(isDefined(var_0)) {
    precachemodel(var_0);
  }

  if(!isDefined(var_1)) {
    var_1 = (0, 0, 0);
  }

  level.var_A056.var_C8F7 = var_0;
  level.var_A056.var_C8F8 = var_1;
}

func_A321(var_0) {
  level.var_90E2.var_1112E = var_0;
}

func_A31E(var_0) {
  level.var_7000 = var_0;
}

func_A2A9(var_0) {
  scripts\sp\pip_util::func_CBA3();

  if(isDefined(self) && isDefined(self.var_CB89) && !isDefined(var_0)) {
    self.var_CB89 delete();
  }
}

func_490C(var_0, var_1) {
  if(!isDefined(var_0)) {
    self.var_CB89 = func_1063A();
  } else {
    self.var_CB89 = var_0;
  }

  thread scripts\engine\utility::delete_on_death(self.var_CB89);
  self.var_CB89 hide();
  var_2 = "tag_player";
  var_3 = "";
  self.var_CB89.origin = self gettagorigin(var_2);
  self.var_CB89 dontinterpolate();
  self.var_CB89 linkto(self, var_2, (0, 0, 0), (0, 0, 0));
  self.var_CB89 give_attacker_kill_rewards(var_3);
  self.var_CB89 show();
}

func_D8FE(var_0) {
  self.var_CB89 endon("death");

  for(;;) {
    iprintln("Pilot dist from linkto tag: " + distance(self.var_CB89.origin, self gettagorigin(var_0)));
    wait 0.05;
  }
}

func_19CF(var_0) {
  scripts\sp\utility::func_75C4("cockpit_pip_light", var_0);
  level scripts\sp\utility::func_178D(scripts\sp\utility::func_137AA, "pip_closed");
  scripts\sp\utility::func_178D(scripts\sp\utility::func_137AA, "death");
  scripts\sp\utility::func_57D6();
  stopFXOnTag(level._effect["cockpit_pip_light"], self, var_0);
}

#using_animtree("generic_human");

func_1063A(var_0, var_1, var_2) {
  var_3 = spawn("script_model", self.origin);
  var_0 = scripts\engine\utility::ter_op(isDefined(var_0), var_0, "body_un_jackal_pilots");
  var_3 setModel(var_0);

  if(!isDefined(var_1)) {
    var_1 = scripts\engine\utility::ter_op(randomint(100) < 50, "head_bg_var_head_sc_engineering_mate_head_male_bc_02", "head_bg_var_head_male_bc_07_head_male_bc_01");
  }

  var_2 = scripts\engine\utility::ter_op(isDefined(var_2), var_2, "helmet_un_jackal_pilots_generic");
  var_3 attach(var_1);
  var_3 attach(var_2);
  var_3 glinton(#animtree);
  var_3.var_8C7E = % head;
  var_3.var_EF82 = % scripted_talking;
  return var_3;
}

func_B156(var_0, var_1, var_2, var_3) {
  var_4 = "tag_flash";

  if(!isDefined(level.var_1656)) {
    level.var_1656 = [];
  }

  for(var_5 = 0; var_5 < var_0; var_5++) {
    thread scripts\sp\utility::play_sound_on_entity("jackal_missile_launch_space_npc");
    var_6 = anglesToForward(self gettagangles(var_4)) * 250;
    var_7 = self gettagorigin(var_4) + (var_6 - (0, 0, 90));
    var_8 = var_7 + anglesToForward(self.angles) * 10000;

    if(!isDefined(var_1)) {
      var_9 = bulletTrace(var_7, var_8, 0, self);
      var_8 = var_9["position"];
      var_10 = magicbullet("spaceship_forward_missile", var_7, var_8);
    } else {
      var_10 = magicbullet("spaceship_homing_missile", var_7, var_1.origin);
      var_10 thread func_B158(var_1, var_2);

      if(isDefined(var_3)) {
        var_10 thread func_699A(var_3, var_1);
      }
    }

    if(isDefined(var_10)) {
      var_10 setCanDamage(0);
    }

    if(var_4 == "tag_flash") {
      var_4 = "tag_flash_2";
    } else {
      var_4 = "tag_flash";
    }

    wait 0.3;
  }
}

func_B158(var_0, var_1) {
  self endon("entitydeleted");
  var_2 = distance(self.origin, var_0.origin);
  var_3 = scripts\sp\math::func_C097(5000, 12000, var_2);
  var_4 = scripts\sp\math::func_6A8E(0, 0.5, var_3);

  if(isDefined(var_1) && var_1) {} else
    wait(var_4);

  if(isDefined(var_0) && isvalidmissile(self) && isDefined(self)) {
    self missile_settargetent(var_0);
  }

  self waittill("death");
  var_0 notify("missile_hit");
}

func_699A(var_0, var_1) {
  self endon("death");
  var_1 endon("death");

  for(;;) {
    if(distance(self.origin, var_1.origin) <= var_0) {
      var_1 notify("detonated");
      self detonate();
    }

    wait 0.05;
  }
}

func_C3DA(var_0, var_1, var_2) {
  self endon("stop_shooting");
  self endon("death");

  while(isDefined(self)) {
    func_C3D9(var_0, undefined, var_1, var_2);
    wait(randomfloatrange(0.3, 2));
  }
}

func_C3DB(var_0, var_1, var_2) {
  if(isDefined(self.var_EF4A)) {
    return;
  }
  self.var_EF4A = 1;

  if(isDefined(self.var_B6B6)) {
    var_3 = self.var_B6B6;
  } else {
    var_3 = "magic_spaceship_30mm_projectile";
  }

  self endon("death");
  var_4 = undefined;
  var_5 = undefined;
  var_6 = "TAG_FLASH_right";

  foreach(var_8 in var_0) {
    if(isai(var_8) && !isalive(var_8)) {
      var_0 = scripts\engine\utility::array_remove(var_0, var_8);
      wait 0.05;
      continue;
    }

    if(scripts\sp\utility::hastag(self.model, var_6)) {
      var_9 = self gettagorigin(var_6) + anglesToForward(self.angles) * 240;
      var_10 = func_7D3F(var_8.origin, var_1, var_2);
      magicbullet(var_3, var_9, var_10, undefined, self);
    }

    if(var_6 == "TAG_FLASH_right") {
      var_6 = "TAG_FLASH_left";
    } else {
      var_6 = "TAG_FLASH_right";
    }

    wait 0.05;
  }

  self.var_EF4A = undefined;
}

func_C3D9(var_0, var_1, var_2, var_3) {
  self endon("death");
  self endon("entitydeleted");
  var_4 = undefined;
  var_5 = undefined;

  if(isDefined(self.var_B6B6)) {
    var_6 = self.var_B6B6;
  } else {
    var_6 = "magic_spaceship_30mm_projectile";
  }

  var_7 = "tag_flash_right";

  if(!isDefined(var_1)) {
    var_1 = randomintrange(5, 15);
  }

  var_8 = 1;

  if(isDefined(var_0)) {
    var_8 = 0;
  }

  for(var_9 = 0; var_9 < var_1; var_9++) {
    var_10 = self gettagorigin(var_7) + anglesToForward(self.angles) * 20;

    if(var_8 || !isDefined(var_0)) {
      var_11 = var_10 + anglesToForward(self.angles) * 1000;
    } else {
      var_11 = func_7D3F(var_0.origin, var_2, var_3);
    }

    magicbullet(var_6, var_10, var_11, undefined, self);

    if(var_7 == "tag_flash_right") {
      var_7 = "tag_flash_left";
    } else {
      var_7 = "tag_flash_right";
    }

    wait 0.05;
  }
}

func_7D3F(var_0, var_1, var_2) {
  if(isDefined(var_2)) {
    if(isDefined(var_1)) {
      return var_0 + scripts\engine\utility::randomvectorrange(var_1, var_2);
    } else {
      return var_0 + scripts\engine\utility::randomvectorrange(0, var_2);
    }
  } else if(isDefined(var_1)) {
    if(isDefined(var_2)) {
      return var_0 + scripts\engine\utility::randomvectorrange(var_1, var_2);
    } else {
      return var_0 + scripts\engine\utility::randomvectorrange(0, var_1);
    }
  }

  return var_0;
}

func_B155(var_0, var_1, var_2, var_3) {
  self notify("stop_MG_magic");
  self endon("death");
  self endon("stop_MG_magic");
  var_4 = "tag_flash";
  var_5 = "magic_spaceship_20mm_bullet";
  var_6 = gettime() + var_0 * 1000;

  if(isDefined(var_3)) {
    var_7 = var_3;
  } else {
    var_7 = 0.1;
  }

  while(var_6 >= gettime()) {
    var_8 = anglestoaxis(self gettagangles(var_4));
    var_9 = var_8["forward"] * 250;
    var_10 = var_8["up"] * -90;
    var_11 = self gettagorigin(var_4) + var_9 + var_10;
    var_12 = var_11 + anglesToForward(self.angles) * 10000;

    if(isDefined(var_1)) {
      if(isDefined(var_1.model) && scripts\sp\utility::hastag(var_1.model, "tag_eye")) {
        var_12 = var_1 gettagorigin("tag_eye");
      } else {
        var_12 = var_1.origin;
      }
    } else {
      var_13 = bulletTrace(var_11, var_12, 0, self);
      var_12 = var_13["position"];
    }

    if(vectordot(var_8["forward"], var_12 - var_11) > 0.0) {
      var_14 = magicbullet(var_5, var_11, var_12);
      playFXOnTag(level._effect["30mm_flash"], self, var_4);

      if(isDefined(var_2)) {
        playFX(var_2, var_12);
      }

      _bullettracer(self gettagorigin(var_4), var_12, var_5, 1);

      if(var_4 == "tag_flash") {
        var_4 = "tag_flash_2";
      } else {
        var_4 = "tag_flash";
      }
    }

    wait(var_7);
  }
}

func_9CBA(var_0) {
  switch (var_0) {
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

func_F43D(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  if(isDefined(self.var_ED2D)) {
    switch (self.var_ED2D) {
      case "player":
        thread func_0BD9::func_556E();
        break;
      case "fake":
        self.var_ED2D = var_0;
        thread func_0C1F::func_552A();
        break;
      case "ai":
        self.var_ED2D = var_0;
        thread func_0C21::func_54F8();
        break;
      case "null":
        self.var_ED2D = var_0;
        break;
      default:
    }
  }

  switch (var_0) {
    case "player":
      self.var_ED2D = var_0;
      func_F387();
      thread func_0BD9::func_622B();
      break;
    case "fake":
      self.var_ED2D = var_0;
      func_F389("j_mainroot_ship");
      thread func_0C1F::func_61F8(var_1);
      break;
    case "ai":
      self.var_ED2D = var_0;
      func_F389("j_mainroot_ship");
      thread func_0C21::func_61CA();
      break;
    case "null":
      self.var_ED2D = var_0;
      func_F389("j_mainroot_ship");
      break;
    default:
  }
}

func_F389(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = "tag_origin";
  }

  if(!isDefined(level.var_A056)) {
    return;
  }
  level.var_A056.var_3818 = scripts\engine\utility::array_removeundefined(level.var_A056.var_3818);

  if(!scripts\engine\utility::array_contains(level.var_A056.var_3818, self)) {
    level.var_A056.var_3818 = scripts\engine\utility::array_add(level.var_A056.var_3818, self);
  }

  self.var_615D = spawnStruct();
  self.var_615D.var_7601 = var_0;
  self.var_615D.var_619D = 0;
  self.var_615D.var_C78B = 0;

  if(isDefined(var_1)) {
    self.var_615D.var_C76E = var_1;
  }
}

func_F387() {
  if(!isDefined(level.var_A056) || !isDefined(level.var_A056.var_3818)) {
    return;
  }
  if(!scripts\engine\utility::array_contains(level.var_A056.var_3818, self)) {
    level.var_A056.var_3818 = scripts\engine\utility::array_remove(level.var_A056.var_3818, self);
  }
}

func_A169() {
  self endon("stop_displaying_speed");
  self endon("death");
  var_0 = (1, 0, 0);

  for(;;) {
    wait 0.05;
  }
}

func_A207(var_0) {
  if(!isDefined(self.var_8E5D)) {
    self.var_8E5D = [];
  }

  if(!scripts\engine\utility::array_contains(self.var_8E5D, var_0)) {
    self.var_8E5D = scripts\engine\utility::array_add(self.var_8E5D, var_0);
  }

  self _meth_8189(var_0);
}

func_A335(var_0) {
  if(!isDefined(self.var_8E5D)) {
    return;
  }
  if(!scripts\engine\utility::array_contains(self.var_8E5D, var_0)) {
    return;
  }
  self.var_8E5D = scripts\engine\utility::array_remove(self.var_8E5D, var_0);
  self showallparts();

  foreach(var_2 in self.var_8E5D) {
    self _meth_8189(var_2);
  }
}

func_A334() {
  self.var_8E5D = [];
  self showallparts();
}

func_A208(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  if(var_0) {
    func_A207("j_mainroot");
    func_A207("tag_cambone");
  } else {
    func_A335("j_mainroot");
    func_A335("tag_cambone");
  }
}

func_1985() {
  if(isDefined(self.var_4074)) {
    return;
  }
  self.var_4074 = [];
  self waittill("entitydeleted");

  if(issentient(self)) {
    self freeentitysentient();
  }

  level.var_A056.var_1630 = scripts\engine\utility::array_remove(level.var_A056.var_1630, self);

  if(self.script_team == "allies") {
    if(scripts\engine\utility::array_contains(level.var_A056.var_1914, self)) {
      level.var_A056.var_1914 = scripts\engine\utility::array_remove(level.var_A056.var_1914, self);
    }
  } else if(scripts\engine\utility::array_contains(level.var_A056.var_191E, self))
    level.var_A056.var_191E = scripts\engine\utility::array_remove(level.var_A056.var_191E, self);

  foreach(var_1 in self.var_4074) {
    if(isDefined(var_1)) {
      var_1 delete();
    }
  }
}

func_1980(var_0, var_1) {
  if(isDefined(var_0)) {}

  if(isDefined(var_1)) {}

  self.var_154D = var_0;
  self.var_734A = var_1;
}

func_6B4C(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  thread func_0C1A::func_A3B6(var_0, 1.0);
  thread func_0C20::func_A3B7(var_0);

  if(!var_1) {
    thread func_0C18::func_A3B5(var_0);
  }

  self.var_6B4E = var_0;
}

func_6B4D() {
  self.audio.state = undefined;
  self.audio.var_552E = undefined;
  self.fx.state = undefined;

  if(isDefined(self.fx.var_552E)) {
    self thread[[self.fx.var_552E]]();
  }

  self.fx.var_552E = undefined;
  self.anims.state = undefined;
  self.var_6B4E = undefined;
}

func_A19D(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  if(var_0) {
    setdvar("scr_jackalDemigod", 1);
  } else {
    setdvar("scr_jackalDemigod", 0);
  }
}

func_A324(var_0) {
  func_A144();
  self setModel(var_0);
  func_A0AF();
}

func_A0AF() {
  if(isDefined(self.var_C899) && self.var_C899 == 1) {
    return;
  }
  if(self.model != "veh_mil_air_un_jackal_02") {
    return;
  }
  self attach("veh_mil_air_un_jackal_02_panels", "j_panel_hide", 1);
  self.var_C899 = 1;
}

func_A144() {
  if(!isDefined(self.var_C899) || self.var_C899 == 0) {
    return;
  }
  if(self.model != "veh_mil_air_un_jackal_02") {
    return;
  }
  self detach("veh_mil_air_un_jackal_02_panels", "j_panel_hide");
  self.var_C899 = 0;
}

func_A1BC() {
  if(isDefined(self.rockets)) {
    return;
  }
  func_0C20::func_AA92();
  func_0C20::func_AA91();
  func_A144();
  var_0 = func_107BA("j_rocket_booster_rear_left1");
  var_1 = func_107BA("j_rocket_booster_rear_left2");
  var_2 = func_107BA("j_rocket_booster_rear_right1");
  var_3 = func_107BA("j_rocket_booster_rear_right2");
  self.rockets = [var_0, var_1, var_2, var_3];
  self.var_4074 = scripts\engine\utility::array_combine(self.var_4074, self.rockets);
}

func_107BA(var_0) {
  var_1 = self gettagorigin(var_0);
  var_2 = spawn("script_model", var_1);
  var_2 setModel("veh_mil_air_un_jackal_01_rocket");
  var_2 linkto(self, var_0, (0, 0, 0), (0, 0, 0));
  return var_2;
}

func_ACF8() {
  for(;;) {
    if(!isDefined(level.var_D127)) {
      var_0 = level.player;
    } else {
      var_0 = level.var_D127;
    }

    wait 0.05;
  }
}

func_A2DC() {
  if(!isDefined(self.rockets)) {
    return;
  }
  foreach(var_1 in self.rockets) {
    self.var_4074 = scripts\engine\utility::array_remove(self.var_4074, var_1);
    var_1 delete();
  }

  self.rockets = undefined;
}

func_A19F() {
  if(isDefined(self.fx.var_13D7E) && self.fx.var_13D7E) {
    return;
  }
  self endon("entitydeleted");
  self endon("dont_start_winglights");
  self notify("dont_stop_winglights");
  var_0 = self.script_team + "_winglight";
  var_1 = self.script_team + "_taillight";
  var_2 = self.script_team + "_bellylight";
  scripts\sp\utility::func_75C4(var_0, "tag_wing_front_left", 0, "dont_start_winglights");
  scripts\sp\utility::func_75C4(var_0, "tag_wing_front_right", 0, "dont_start_winglights");
  scripts\sp\utility::func_75C4(var_1, "tag_wing_rear_left", 0, "dont_start_winglights");
  scripts\sp\utility::func_75C4(var_1, "tag_wing_rear_right", 0, "dont_start_winglights");
  scripts\sp\utility::func_75C4(var_2, "tag_bottom_light", 0, "dont_start_winglights");
  self.fx.var_13D7E = 1;
}

func_A167() {
  if(!isDefined(self.fx.var_13D7E) || isDefined(self.fx.var_13D7E) && !self.fx.var_13D7E) {
    return;
  }
  self endon("entitydeleted");
  self endon("dont_stop_winglights");
  self notify("dont_start_winglights");
  var_0 = self.script_team + "_winglight";
  var_1 = self.script_team + "_taillight";
  var_2 = self.script_team + "_bellylight";
  scripts\sp\utility::func_75F8(var_0, "tag_wing_front_left", 0, "dont_stop_winglights");
  scripts\sp\utility::func_75F8(var_0, "tag_wing_front_right", 0, "dont_stop_winglights");
  scripts\sp\utility::func_75F8(var_1, "tag_wing_rear_left", 0, "dont_stop_winglights");
  scripts\sp\utility::func_75F8(var_1, "tag_wing_rear_right", 0, "dont_stop_winglights");
  scripts\sp\utility::func_75F8(var_2, "tag_bottom_light", 0, "dont_stop_winglights");
  self.fx.var_13D7E = 0;
}

func_77E0() {
  var_0 = level.var_A056.var_1630;
  var_0 = scripts\engine\utility::array_removeundefined(var_0);
  return var_0;
}

func_77D8() {
  var_0 = level.var_A056.var_191E;
  var_0 = scripts\engine\utility::array_removeundefined(var_0);
  return var_0;
}

func_19A4(var_0) {
  self._blackboard.var_90F3 = var_0;
}

func_19B8(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  if(var_0) {
    self.var_3D4F = 1;
  } else {
    self.var_3D4F = undefined;
  }
}

func_19AA(var_0) {
  self giveflagassistedcapturepoints(var_0);
  self.weapon = var_0;
  self.var_13C87 = weaponfiretime(self.weapon);
  self.var_13C87 = max(self.var_13C87, 0.05);
}

func_19A8(var_0) {
  self._blackboard.var_D9BA = var_0;
}

func_19A6(var_0) {
  if(isDefined(var_0) && var_0) {
    func_19B0("fly");
    self._blackboard.var_AAB2 = var_0;
  } else {
    self._blackboard.var_AAB2 = 0;
    func_19B0("none");
  }
}

func_198F(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  self _meth_8555(var_0);
}

func_1983() {
  if(!isDefined(self._blackboard)) {
    return;
  }
  if(isDefined(self._blackboard.var_A421)) {
    self._blackboard.var_A421 func_1983();
    return;
  }

  if(isDefined(self.var_A420)) {
    foreach(var_1 in self.var_A420) {
      if(isalive(var_1)) {
        var_1._blackboard.var_A421 = undefined;
        var_1 func_19B7();
      }
    }

    self.var_A420 = undefined;
  }
}

func_199F() {
  if(isDefined(self._blackboard.var_A421)) {
    self._blackboard.var_A421.var_A420 = scripts\engine\utility::array_remove(self._blackboard.var_A421.var_A420, self);
  }

  self._blackboard.var_A421 = undefined;
  func_19B7();
}

func_A253(var_0) {
  if(!isDefined(self.var_A420)) {
    self.var_A420 = [];
  }

  self.var_A420[self.var_A420.size] = var_0;
}

func_1991(var_0) {
  self endon("death");
  self notify("new_evade_anim");

  if(isDefined(self.var_67C7) && self.var_67C7) {
    return;
  }
  if(isDefined(var_0)) {
    var_1 = var_0;
    var_2 = 1;
  } else {
    var_2 = 0;
    var_1 = level.var_A065["evasion"][level.var_A056.var_67D8];
  }

  self _meth_82AB(var_1, 1, 0.0);
  self give_attacker_kill_rewards(level.var_A065["evasion_overlay"], 1.0);

  if(!var_2) {
    level.var_A056.var_67D8++;

    if(level.var_A056.var_67D8 == level.var_A065["evasion"].size) {
      level.var_A056.var_67D8 = 0;
      level.var_A065["evasion"] = ::scripts\engine\utility::array_randomize(level.var_A065["evasion"]);
    }
  }

  self.var_67C7 = 1;
  var_3 = 0.7;
  wait(getanimlength(var_1) * var_3);
  self.var_67C7 = 0;
  self endon("new_evade_anim");
  wait(getanimlength(var_1) * (1 - var_3));
}

func_199E(var_0, var_1) {
  self._blackboard.var_A421 = var_0;
  var_0 func_A253(self);

  if(!isDefined(var_1)) {
    var_1 = self.origin - var_0.origin;
    var_1 = rotatevectorinverted(var_1, var_0.angles);
  }

  func_1994(var_0, var_1);
}

func_19B3(var_0, var_1) {
  self._blackboard.var_10A4D[var_0] = var_1;
}

func_19B4(var_0) {
  self._blackboard.var_10A4B = var_0;
}

func_A202(var_0) {
  var_1 = self gettagorigin("tag_flash_right");
  var_2 = var_0.origin + (0, 0, 30);
  var_3 = scripts\engine\trace::create_contents(1, 1, 0, 1, 1, 1);
  var_4 = scripts\engine\trace::ray_trace(var_1, var_2, undefined, var_3, 1);

  if(isDefined(var_4["entity"]) && var_4["entity"] == var_0) {
    return 1;
  }

  return 0;
}

func_A288(var_0) {
  if(var_0) {
    func_1980(1, 1);
  } else {
    func_1980();
  }
}

func_A0B3(var_0) {
  self._blackboard.var_2520 = var_0;
}

func_A342(var_0, var_1, var_2) {
  if(isDefined(self._blackboard)) {
    func_1981();
  }

  if(!isDefined(var_0)) {}

  if(isDefined(var_2) && var_2) {
    var_3 = self.origin;
  } else {
    var_3 = undefined;
  }

  func_0C24::func_10A46(var_0, var_1, var_3);
}

func_F5BD(var_0) {
  switch (var_0) {
    case "runway":
      self.var_11474 = func_0BDB::func_1147D;
      break;
    case "retribution":
      self.var_11474 = func_0BDB::func_1147C;
      break;
    case "shipcrib":
      self.var_11474 = func_0BDB::func_11486;
      break;
    case "instant":
      self.var_11474 = func_0BDB::func_11478;
      break;
    case "vtol":
      self.var_11474 = func_0BDB::func_1148A;
      break;
    case "hovering":
      self.var_11474 = func_0BDB::func_11477;
      break;
    case "ship_assault_gunner":
      self.var_11474 = func_0BDB::func_11484;
      break;
    case "phspace_launch":
      self.var_11474 = func_0BDB::func_11479;
      break;
    default:
  }

  self.var_11488 = var_0;
}

func_7BBA() {
  var_0 = level.player _meth_8473();

  if(isDefined(var_0)) {
    return var_0.origin;
  } else {
    return level.player.origin;
  }
}

func_7BB9() {
  var_0 = level.player _meth_8473();

  if(isDefined(var_0)) {
    return var_0.angles;
  } else {
    return level.player.angles;
  }
}

func_F448(var_0) {
  switch (var_0) {
    case "instant":
      self.var_A7B9 = func_0BDB::func_A7BB;
      break;
    default:
  }

  self.var_A7C1 = var_0;
}

func_F48D(var_0) {
  switch (var_0) {
    case "default_landed":
      self.var_BBD4 = func_0BDB::func_BBD0;
      func_F420(500, 135, -30, 1, 1);
      break;
    case "runway":
      self.var_BBD4 = func_0BDB::func_BBE4;
      func_F420(500, 135, 0, 1, 1);
      break;
    case "runway_moon":
      self.var_BBD4 = func_0BDB::func_BBE5;
      func_F420(500, 135, 0, 1, 1);
      break;
    case "titan_breifing":
      self.var_BBD4 = func_0BDB::func_BBE9;
      func_F420(500, 135, 30, 1, 1);
      break;
    case "instant_fly":
      self.var_BBD4 = func_0BDB::func_BBDB;
      func_F420(500, 135, -30, 0, 0);
      break;
    case "instant_hover":
      self.var_BBD4 = func_0BDB::func_BBD8;
      func_F420(500, 135, -30, 0, 0);
      break;
    case "instant_land":
      self.var_BBD4 = func_0BDB::func_BBD9;
      func_F420(500, 135, -30, 0, 0);
      break;
    case "jump_in":
      func_F420(500, 135, 30, 1, 1);
      self.var_BBD4 = func_0BDB::func_BBDD;
      break;
    case "zero_g":
      func_F420(500, 135, 30, 1, 1);
      self.var_BBD4 = func_0BDB::func_BBEF;
      break;
    case "zero_g_enemy":
      func_F420(500, 135, 30, 1, 1);
      self.var_BBD4 = func_0BDB::func_BBF0;
      break;
    case "crib_launch":
      func_F420(500, 135, -30, 1, 1);
      self.var_BBD4 = func_0BDB::func_BBCF;
      break;
    case "shipcrib_europa_launch":
      func_F420(500, 135, -30, 0, 1);
      self.var_BBD4 = func_0BDB::func_BBE6;
      break;
    case "retribution":
      func_F420(500, 135, -30, 1, 1);
      self.var_BBD4 = func_0BDB::func_BBD9;
      break;
    case "visor_pulldown_landed":
      func_F420(500, 135, -30, 1, 1);
      self.var_BBD4 = func_0BDB::func_BBDE;
      break;
    default:
  }

  self.var_BBEB = var_0;
}

func_F48C(var_0, var_1, var_2, var_3) {
  if(isDefined(var_0)) {
    self.var_1EE1 = var_0;
  }

  if(isDefined(var_1)) {
    self.var_1EE2 = var_1;
  }

  if(isDefined(var_2)) {
    self.var_1F20 = var_2;
  }

  if(isDefined(var_2)) {
    self.var_1F21 = var_3;
  }
}

func_F358(var_0) {
  switch (var_0) {
    case "default_landed":
      self.var_5688 = func_0BDB::func_5685;
      break;
    case "zero_g":
      self.var_5688 = func_0BDB::func_56A6;
      break;
    case "crib_craneride":
      self.var_5688 = func_0BDB::func_5684;
      break;
    case "dismount_shipcrib_moon":
      self.var_5688 = func_0BDB::func_56A0;
      break;
    case "dismount_shipcrib_gravity":
      self.var_5688 = func_0BDB::func_569F;
      break;
    case "instant":
      self.var_5688 = func_0BDB::func_568E;
      break;
    case "moon_dismount":
      self.var_5688 = func_0BDB::func_5695;
      break;
    case "heist_mons_breach":
      self.var_5688 = func_0BDB::func_568B;
      break;
    default:
  }

  self.var_56A4 = var_0;
}

func_F420(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(self.var_99F5)) {
    self.var_99F5 = spawnStruct();
    self.var_99F5.var_BBF1 = 0;
    self.var_99F5.var_AB4B = 1;
    self.var_99F5.var_E526 = 1;
    self.var_99F5.draw_distance = 500;
    self.var_99F5.var_12FC3 = 130;
    self.var_99F5.height = -30;
    self.var_99F5.var_56B6 = 35;
  }

  if(isDefined(var_3)) {
    self.var_99F5.var_AB4B = var_3;
  }

  if(isDefined(var_4)) {
    self.var_99F5.var_E526 = var_4;
  }

  if(isDefined(var_0)) {
    self.var_99F5.draw_distance = var_0;
  }

  if(isDefined(var_1)) {
    self.var_99F5.var_12FC3 = var_1;
  }

  if(isDefined(var_2)) {
    self.var_99F5.height = var_2;
  }

  func_DE6D();
}

#using_animtree("jackal");

func_A2DE(var_0, var_1, var_2, var_3) {
  var_1 = 0;

  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  if(!isDefined(var_1)) {
    var_1 = 0.2;
  }

  self _meth_848F(var_0);

  if(var_0 && !var_2) {
    self clearanim( % jackal_thrust_p, var_1);
    self clearanim( % jackal_motion_idle_p, var_1);
    self clearanim( % root, var_1);
    self clearanim( % jackal_assault_lhand_fb_range_p, var_1);
    self clearanim( % jackal_assault_lhand_lr_range_p, var_1);
    self clearanim( % jackal_assault_rhand_fb_range_p, var_1);
    self clearanim( % jackal_assault_rhand_lr_range_p, var_1);
    self clearanim( % jackal_strike_lhand_fb_range_p, var_1);
    self clearanim( % jackal_strike_lhand_lr_range_p, var_1);
    self clearanim( % jackal_strike_rhand_fb_range_p, var_1);
    self clearanim( % jackal_strike_rhand_lr_range_p, var_1);
  }

  if(var_0 && !var_3) {
    self clearanim( % jackal_weapon_switch_p, var_1);
    self clearanim( % jackal_weapon_drop_p, var_1);
    self clearanim( % jackal_vehicle_weap_primary_fire_l_p, var_1);
    self clearanim( % jackal_vehicle_weap_primary_fire_r_p, var_1);
    self clearanim( % jackal_vehicle_weap_secondary_fire_l_p, var_1);
    self clearanim( % jackal_vehicle_weap_secondary_fire_r_p, var_1);
  }
}

func_A16F() {
  while(level.var_A056.var_56F9.size == 0) {
    wait 0.05;
  }

  for(;;) {
    while(!isDefined(level.var_D127)) {
      wait 0.05;
    }

    level.var_A056.var_56F9 = scripts\engine\utility::array_removeundefined(level.var_A056.var_56F9);

    if(level.var_A056.var_56F9.size == 0) {
      break;
    }
    var_0 = 1;
    var_1 = 1;
    var_2 = anglesToForward(level.var_D127.angles);
    var_3 = level.var_D127.origin;

    foreach(var_5 in level.var_A056.var_56F9) {
      if(!isDefined(var_5)) {
        continue;
      }
      if(isDefined(var_5.var_A496)) {
        var_6 = level.var_D127.origin - var_5.origin;
        var_7 = rotatevectorinverted(var_6, var_5.angles);
        var_8 = func_394B(var_7[0], var_5.var_A496);
        var_9 = func_394B(var_7[1], var_5.var_A497);
        var_10 = func_394B(var_7[2], var_5.var_A498);
        var_7 = (var_8, var_9, var_10);
        var_6 = rotatevector(var_7, var_5.angles);
        var_5.var_A493 = var_5.origin + var_6;
      } else
        var_5.var_A493 = var_5.origin;

      var_11 = distance(var_5.var_A493, level.var_D127.origin);
      var_12 = scripts\sp\math::func_C097(var_5.var_A492, var_5.var_A490, var_11);
      var_13 = scripts\sp\math::func_6A8E(var_5.var_A494, 1, var_12);

      if(isDefined(var_5.var_A491)) {
        var_14 = vectordot(vectornormalize(var_5.var_A493 - var_3), var_2);
        var_12 = scripts\sp\math::func_C097(-0.5, 0.2, var_14);
        var_13 = scripts\sp\math::func_6A8E(1, var_13, var_12);
      }

      if(isDefined(var_5.var_A494)) {
        var_15 = scripts\sp\math::func_6A8E(var_5.var_A48F, 1, var_12);
      }

      if(var_13 < var_0) {
        var_0 = var_13;
      }

      if(var_13 < var_0) {
        var_0 = var_13;
      }
    }

    func_A301(var_0, 0.05, "radius_dist");
    func_A2FC(var_1, 0.05, "radius_dist");
    wait 0.05;
  }

  level.var_A056.var_56F9 = undefined;
}

func_394B(var_0, var_1) {
  var_1 = var_1 * 0.5;

  if(var_0 > var_1) {
    var_0 = var_1;
  } else if(var_0 < var_1 * -1) {
    var_0 = var_1 * -1;
  }

  return var_0;
}

func_A2DF() {
  thread func_A2E0();
}

func_A2E0() {
  if(!scripts\sp\utility::func_B324()) {
    return;
  }
  level.var_A056.var_E1A6 = scripts\engine\utility::array_removeundefined(level.var_A056.var_E1A6);
  level.var_A056.var_E1A6 = scripts\engine\utility::array_add(level.var_A056.var_E1A6, self);
  var_0 = "repulser_force" + level.var_A056.var_E1A5;
  level.var_A056.var_E1A5++;

  for(;;) {
    if(!isDefined(level.var_D127)) {
      wait 0.05;
      continue;
    }

    if(!isDefined(self)) {
      break;
    }
    scripts\engine\utility::waittill_any("slowdown_point_factored", "death", "repulser_removed");

    if(!isDefined(self) || !scripts\engine\utility::array_contains(level.var_A056.var_E1A6, self)) {
      break;
    }
    if(level.var_D127.var_C2CB) {
      var_1 = level.var_D127.spaceship_vel;
      var_2 = self.var_A493 - level.var_D127.origin;
      var_3 = length(var_2);
      var_4 = scripts\sp\math::func_C097(-200, 750, var_3);
      var_5 = scripts\sp\math::func_6A8E(self.origin, self.var_A493, var_4);
      var_6 = var_5 - level.var_D127.origin;
      var_7 = vectornormalize(var_6);
      var_8 = vectordot(var_1, var_7);
      var_8 = max(0, var_8);
      var_3 = length(var_2);
      var_4 = scripts\sp\math::func_C097(2000, 8000, var_3);
      var_9 = scripts\sp\math::func_6A8E(-0.5 * var_8, 0, var_4);
      var_10 = scripts\sp\math::func_6A8E(var_8, 0, var_4);
      var_11 = var_9 * var_7;
      var_12 = 1 - scripts\sp\math::func_C097(20, 100, var_10);
      func_A301(var_12, 0, var_0);
      func_A2FC(var_12, 0, var_0);
      func_A078(var_11, 0, var_0);
      continue;
    }

    func_A078((0, 0, 0), 0, var_0);
    func_A301(1, 0, var_0);
    func_A2FC(1, 0, var_0);
  }

  func_A34D();
  func_A078((0, 0, 0), 0, var_0);
}

func_A34D() {
  if(isDefined(self) && scripts\engine\utility::array_contains(level.var_A056.var_E1A6, self)) {
    self notify("repulser_removed");
    level.var_A056.var_E1A6 = scripts\engine\utility::array_remove(level.var_A056.var_E1A6, self);
  }
}

func_A16E(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(!isDefined(level.var_A056.var_56F9)) {
    level.var_A056.var_56F9 = [];
    level thread func_A16F();
  }

  self.var_A492 = var_0;
  self.var_A490 = var_1;
  self.var_A494 = var_2;

  if(isDefined(var_3)) {
    self.var_A48F = var_3;
  }

  if(isDefined(var_4)) {
    self.var_A496 = var_4;
    self.var_A497 = var_5;
    self.var_A498 = var_6;
  }

  if(isDefined(var_7)) {
    self.var_A491 = var_7;
  } else {
    self.var_A491 = 0;
  }

  self.var_A495 = 1;
  level.var_A056.var_56F9 = scripts\engine\utility::array_add(level.var_A056.var_56F9, self);
}

func_A16B(var_0) {
  thread func_A16C(var_0);
}

func_A16C(var_0) {
  self endon("death");

  if(isDefined(var_0)) {
    for(var_1 = var_0; var_1 > 0; var_1 = var_1 - 0.05) {
      self.var_A495 = scripts\sp\math::func_C097(0, var_0, var_1);
      wait 0.05;
    }
  }

  level.var_A056.var_56F9 = scripts\engine\utility::array_remove(level.var_A056.var_56F9, self);
}

func_A25B(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(level.var_D127.linked_ents)) {
    level.var_D127.linked_ents = [];
  }

  level.var_D127.linked_ents = scripts\engine\utility::array_removeundefined(level.var_D127.linked_ents);
  self.var_AD25 = var_2;
  self.var_AD19 = var_3;
  self.var_AD42 = var_1;

  if(!scripts\engine\utility::array_contains(level.var_D127.linked_ents, self)) {
    level.var_D127.linked_ents = scripts\engine\utility::array_add(level.var_D127.linked_ents, self);
  }

  if(isDefined(var_5) && var_5) {
    self linkto(level.var_D127, var_1, var_2, var_3);
  } else if(!isDefined(var_4)) {
    level.player.spaceship_linked_ent = self;
    level.player _meth_8468(self, var_1, var_0, var_2, var_3);
  } else {
    self.start = scripts\engine\utility::spawn_tag_origin(self.origin, self.angles - (0, 180, 0));
    thread func_2B74(self.start, level.var_D127, var_0, 0, "tag_origin", "j_canopy");
  }
}

func_A387() {
  if(isDefined(level.var_D127) && isDefined(level.var_D127.linked_ents) && scripts\engine\utility::array_contains(level.var_D127.linked_ents, self)) {
    level.var_D127.linked_ents = scripts\engine\utility::array_remove(level.var_D127.linked_ents, self);

    if(!isDefined(level.player.spaceship_linked_ent) || level.player.spaceship_linked_ent == self) {
      level.player _meth_8469();
      level.player.spaceship_linked_ent = undefined;
    }
  }
}

func_A386(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  level.player _meth_8490("unlimited_boost", var_0);
}

func_A160(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  if(!isDefined(var_1)) {
    var_1 = 0.0;
  }

  if(var_0) {
    level.player scripts\sp\utility::func_65E1("disable_jackal_quickturn");
    var_2 = 0;
  } else {
    level.player scripts\sp\utility::func_65DD("disable_jackal_quickturn");
    var_2 = 1;
  }

  level.var_D127 thread func_DBA5(var_2, var_1);
}

func_DBA5(var_0, var_1) {
  self notify("blend_quickturn_master");
  self endon("blend_quickturn_master");

  if(!isDefined(self.var_DBA2)) {
    return;
  }
  if(var_1 == 0) {
    self.var_DBA2.var_B3D1 = var_0;
    return;
  }

  self.var_DBA2.var_2B8D = 1;
  var_2 = (var_0 - self.var_DBA2.var_B3D1) / var_1 * 0.05;
  var_3 = self.var_DBA2.var_B3D1;
  var_4 = var_1;

  while(var_4 > 0) {
    var_3 = var_3 + var_2;
    self.var_DBA2.var_B3D1 = clamp(var_3, 0, 1);
    var_4 = var_4 - 0.05;
    self notify("quickturn_master_blend_complete");
    level.player waittill("on_player_update");
  }

  self.var_DBA2.var_B3D1 = var_0;
  self notify("quickturn_master_blend_complete");
  self.var_DBA2.var_2B8D = 0;
}

func_12DCD(var_0) {
  var_1 = ["weapons", "thrusters", "hull", "none"];

  if(!scripts\engine\utility::array_contains(var_1, var_0)) {}

  level.var_A056.var_D3C1 = var_0;
  func_12DD0(var_0 == "weapons");
  func_12DCF(var_0 == "thrusters");
  func_12DCE(var_0 == "hull");
}

func_12DD0(var_0) {
  if(isDefined(level.var_D127.var_4C15)) {
    level.var_D127 func_0BD9::func_D17E();
  }

  if(isDefined(level.var_D127.missiles)) {
    func_0BDD::func_A27B();
  }
}

func_12DCF(var_0) {
  level.var_D127 func_0BD9::func_A31B();

  if(var_0) {
    return;
  }
  return;
}

func_12DCE(var_0) {
  level.var_D127 func_0BD5::func_F481();

  if(var_0) {
    return;
  }
  return;
}

func_A07D() {
  if(!scripts\sp\utility::func_B324()) {
    return;
  }
  if(isDefined(self.var_4F5E)) {
    self.var_4F5E delete();
  }

  self.var_FF24 = 1;

  if(func_A2A7()) {
    return;
  }
  var_0 = func_0A2F::func_D9FB();

  if(self.model == "veh_mil_air_un_jackal_landed_03b") {
    var_1 = (-3.99147, 0, -15.6889);
  } else {
    var_1 = (0, 0, 0);
  }

  self.var_4F5E = spawn("script_model", self.origin);
  self.var_4F5E setModel(var_0);
  self.var_4F5E linkto(self, "tag_body", var_1, (0, 0, 0));
}

func_A077(var_0) {
  if(isDefined(self.var_4F5E)) {
    self.var_4F5E delete();
  }

  var_1 = strtok(var_0, "_");
  var_2 = var_1.size - 1;
  var_3 = "livery_" + var_1[var_2 - 1] + "_" + var_1[var_2] + "_tr";

  if(!scripts\engine\utility::flag(var_3 + "_loaded")) {
    scripts\sp\utility::func_12641(var_3);
  }

  self.var_4F5E = spawn("script_model", self.origin);
  self.var_4F5E setModel(var_0);
  self.var_4F5E linkto(self, "tag_body", (0, 0, 0), (0, 0, 0));
}

func_A2DA() {
  if(isDefined(self.var_4F5E)) {
    self.var_4F5E delete();
  }
}

func_8B87() {
  if(self.var_93D2.size > 0) {
    return 1;
  } else {
    return 0;
  }
}

func_1378D(var_0) {
  self endon("death");

  for(;;) {
    if(func_9C1B(var_0)) {
      break;
    }
    wait 0.05;
  }
}

func_137C2(var_0) {
  self endon("death");

  for(;;) {
    if(!func_9C1B(var_0)) {
      break;
    }
    wait 0.05;
  }
}

func_9C1B(var_0) {
  var_1 = func_0B76::func_7A60(self.origin);

  if(var_1 > var_0) {
    return 1;
  } else {
    return 0;
  }
}

func_1378C(var_0) {
  self endon("death");

  for(;;) {
    if(func_9C1A(var_0)) {
      break;
    }
    wait 0.05;
  }
}

func_137C1(var_0) {
  self endon("death");

  for(;;) {
    if(!func_9C1A(var_0)) {
      break;
    }
    wait 0.05;
  }
}

func_9C1A(var_0) {
  var_1 = distance(self.origin, level.var_D127.origin);

  if(var_1 < var_0) {
    return 1;
  } else {
    return 0;
  }
}

func_A149(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  if(var_0) {
    var_0 = 0;
    level.player scripts\sp\utility::func_65E1("disable_jackal_ads");
    level.player _meth_8490("disable_lockon", 1);
  } else {
    var_0 = 1;
    level.player scripts\sp\utility::func_65DD("disable_jackal_ads");

    if(!level.player scripts\sp\utility::func_65DB("disable_jackal_lockon")) {
      level.player _meth_8490("disable_lockon", 0);
    }
  }

  level.player allowads(var_0);
}

func_A14D(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  level.player _meth_8490("disable_collision", var_0);

  if(var_0) {
    _setsaveddvar("spaceshipResolvePenetration", 0);
  } else {
    _setsaveddvar("spaceshipResolvePenetration", 1);
  }
}

func_A14A(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  level.player _meth_8490("disable_boost", var_0);
}

func_A162(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  if(var_0) {
    level.player scripts\sp\utility::func_65E1("disable_jackal_targetAid");
  } else {
    level.player scripts\sp\utility::func_65DD("disable_jackal_targetAid");
  }
}

func_A35D(var_0, var_1) {
  level notify("new_target_aid_pool");
  level.var_A056.var_EF83 = var_0;

  if(isDefined(var_1) && var_1) {
    thread func_A35E();
  }
}

func_A35E() {
  level endon("new_target_aid_pool");

  while(isDefined(level.var_A056.var_EF83) && level.var_A056.var_EF83.size > 0) {
    level.var_A056.var_EF83 = scripts\engine\utility::array_removeundefined(level.var_A056.var_EF83);
    wait 0.05;
  }

  level.var_A056.var_EF83 = undefined;
}

func_A163(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  if(var_0) {
    level.player scripts\sp\utility::func_65E1("disable_jackal_targetAid_update");
  } else {
    level.player scripts\sp\utility::func_65DD("disable_jackal_targetAid_update");
  }
}

jackal_disable_damage_vision_distortion(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  if(var_0) {
    level.player scripts\sp\utility::func_65E1("disable_jackal_damage_vision_distortion");
  } else {
    level.player scripts\sp\utility::func_65DD("disable_jackal_damage_vision_distortion");
  }
}

jackal_engine_throttle_sfx_volume(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  var_0 = clamp(var_0, 0, 1);
  level.var_D127 thread jackal_engine_throttle_sfx_volume_internal(var_0, var_1);
}

jackal_engine_throttle_sfx_volume_internal(var_0, var_1) {
  self notify("new_engine_throttle_volume");
  self endon("new_engine_throttle_volume");
  self endon("player_exit_jackal");
  self endon("death");

  if(!isDefined(self.engine_master_volume)) {
    self.engine_master_volume = 0;
  }

  var_2 = self.engine_master_volume;

  for(var_3 = var_1; var_3 > 0; var_3 = var_3 - 0.05) {
    var_4 = scripts\sp\math::func_C097(0, var_1, var_3);
    self.engine_master_volume = scripts\sp\math::func_6A8E(var_0, var_2, var_4);
    wait 0.05;
  }

  self.engine_master_volume = var_0;
}

func_A14C(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  level.var_D127.var_5509 = var_0;
}

func_A15C(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  if(var_0) {
    level.player scripts\sp\utility::func_65E1("disable_jackal_mode_switch");
  } else {
    level.player scripts\sp\utility::func_65DD("disable_jackal_mode_switch");
  }
}

func_A154(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  if(var_0) {
    level.player scripts\sp\utility::func_65E1("disable_jackal_cockpit_VO");
  } else {
    level.player scripts\sp\utility::func_65DD("disable_jackal_cockpit_VO");
  }
}

func_A15B(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  if(var_0) {
    level.player scripts\sp\utility::func_65E1("disable_jackal_missiles");
  } else {
    level.player scripts\sp\utility::func_65DD("disable_jackal_missiles");
  }
}

func_A14F(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  if(var_0) {
    level.player scripts\sp\utility::func_65E1("disable_jackal_emp");
  } else {
    level.player scripts\sp\utility::func_65DD("disable_jackal_emp");
  }
}

func_A158(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  if(var_0) {
    level.player scripts\sp\utility::func_65E1("disable_jackal_map_boundary_autoturn");
  } else {
    level.player scripts\sp\utility::func_65DD("disable_jackal_map_boundary_autoturn");
  }
}

func_A159(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  if(var_0) {
    level.player scripts\sp\utility::func_65E1("disable_jackal_map_boundary_push");
  } else {
    level.player scripts\sp\utility::func_65DD("disable_jackal_map_boundary_push");
  }
}

func_A15A(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  if(var_0) {
    level.player scripts\sp\utility::func_65E1("disable_jackal_map_boundary_warning");
  } else {
    level.player scripts\sp\utility::func_65DD("disable_jackal_map_boundary_warning");
  }
}

func_A155(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  if(var_0) {
    level.player scripts\sp\utility::func_65E1("disable_jackal_juke");
  } else {
    level.player scripts\sp\utility::func_65DD("disable_jackal_juke");
  }

  level.player _meth_8490("disable_juke", var_0);
}

func_A161(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  if(var_0) {
    level.player scripts\sp\utility::func_65E1("disable_jackal_roll");
  } else {
    level.player scripts\sp\utility::func_65DD("disable_jackal_roll");
  }

  if(scripts\sp\utility::func_D123()) {
    func_0BD9::func_F380();
  }
}

func_A15E(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  if(var_0) {
    level.player scripts\sp\utility::func_65E1("disable_jackal_overheat");
  } else {
    level.player scripts\sp\utility::func_65DD("disable_jackal_overheat");
  }
}

func_A14E(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  if(var_0) {
    level.player scripts\sp\utility::func_65E1("disable_jackal_dogfight");
  } else {
    level.player scripts\sp\utility::func_65DD("disable_jackal_dogfight");
  }
}

func_A151(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  if(var_0) {
    level.player scripts\sp\utility::func_65E1("disable_jackal_flares");
  } else {
    level.player scripts\sp\utility::func_65DD("disable_jackal_flares");
  }
}

func_A153(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  if(var_0 && !level.player scripts\sp\utility::func_65DB("disable_jackal_guns")) {
    level.player scripts\sp\utility::func_65E1("disable_jackal_guns");
    func_A152(var_1);
  } else if(!var_0 && level.player scripts\sp\utility::func_65DB("disable_jackal_guns")) {
    level.player scripts\sp\utility::func_65DD("disable_jackal_guns");
    func_A19E(var_1);
  }
}

func_A152(var_0) {
  if(var_0) {
    level.var_D127 notify("spaceship_weapon_state_change", "silent");
  }

  level.var_D127 _meth_849E("spaceship_disabled_guns");
  thread func_A157();
  level.var_D127 _meth_849F(0);
  level.player allowads(0);
  setomnvar("ui_jackal_weapon_display_temp", 0);
}

func_A19E(var_0) {
  if(var_0) {
    level.var_D127 notify("spaceship_weapon_state_change", "silent");
  }

  level.var_D127 func_0BD9::func_D17E();

  if(!level.player scripts\sp\utility::func_65DB("disable_jackal_lockon")) {
    level.player _meth_8490("disable_lockon", 0);
  }

  level.var_D127 _meth_849F(1);
  level.player allowads(1);

  if(!level.player scripts\sp\utility::func_65DB("disable_jackal_overheat")) {
    setomnvar("ui_jackal_weapon_display_temp", 1);
  }
}

func_A166(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  if(var_0) {
    level.player scripts\sp\utility::func_65E1("disable_jackal_weapon_switch");
  } else {
    level.player scripts\sp\utility::func_65DD("disable_jackal_weapon_switch");
  }
}

setentityowner(var_0) {
  self.missiles.count = self.missiles.count + var_0;

  if(self.missiles.count > self.missiles.var_B446) {
    self.missiles.count = self.missiles.var_B446;
  }

  setomnvar("ui_jackal_missile_count", self.missiles.count);
}

func_10CD8() {
  thread func_E047();
}

func_E047() {
  while(!isDefined(level.var_D127)) {
    wait 0.05;
  }

  while(!isDefined(level.var_D127.missiles)) {
    wait 0.05;
  }

  level.var_D127.missiles.count = 0;
  setomnvar("ui_jackal_missile_count", level.var_D127.missiles.count);
}

func_A157() {
  level.player endon("disable_jackal_guns");
  func_137DB();
  level.player _meth_8490("disable_lockon", 1);
}

func_13C11(var_0, var_1) {
  level.var_D127 endon("player_exit_jackal");

  if(isDefined(var_1)) {
    wait(var_1);
  }

  level.player playSound(var_0);
}

func_A15F(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  if(var_0) {
    level.player scripts\sp\utility::func_65E1("disable_jackal_pilot_assist");
  } else {
    level.player scripts\sp\utility::func_65DD("disable_jackal_pilot_assist");
  }

  level.player _meth_8490("disable_pilot_aim_assist", var_0);
  level.player _meth_8490("disable_pilot_move_assist", var_0);
}

func_A15D(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  if(var_0) {
    level.var_A056.var_1C54 = 0;
  } else {
    level.var_A056.var_1C54 = 1;
  }
}

func_A14B(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  if(var_0) {
    level.var_A056.var_1C3C = 0;
  } else {
    level.var_A056.var_1C3C = 1;
  }
}

func_A165(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  if(var_0) {
    level.var_A056.var_1C6D = 0;
  } else {
    level.var_A056.var_1C6D = 1;
  }
}

func_A1AA(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawnStruct();
  var_5.var_10974 = var_1;
  var_5.main = var_2;
  var_5.var_4623 = var_3;
  var_5.var_C6B4 = var_4;
  var_5.var_54F1 = 0;
  var_5.cooling_down = 0;
  var_5.running = 0;
  level.var_A056.var_68B3.var_68B6[var_0] = var_5;
}

func_A1AD(var_0) {
  level.var_A056.var_68B3.var_68B6 = scripts\sp\utility::func_22B2(level.var_A056.var_68B3.var_68B6, var_0);
}

func_A1AB(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  if(!isDefined(level.var_A056.var_68B3.var_68B6[var_0])) {
    return;
  }
  level.var_A056.var_68B3.var_68B6[var_0].var_54F1 = var_1;
}

jackal_eventmanager_event_is_running(var_0) {
  if(!isDefined(level.var_A056.var_68B3.var_68B6[var_0])) {
    return 0;
  }

  return level.var_A056.var_68B3.var_68B6[var_0].running;
}

func_A1AE(var_0) {
  while(!isDefined(level.var_A056.var_68B3.var_68B6[var_0])) {
    wait 0.05;
  }
}

func_A1AC(var_0) {
  return isDefined(level.var_A056.var_68B3.var_68B6[var_0]);
}

func_A1A9(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  level.var_A056.var_68B3.var_54F1 = var_0;
}

func_A1DD(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  if(!isstring(var_0) && var_0 == 0) {
    level.player scripts\sp\utility::func_65DD("jackal_force_mode");
    level.var_D127.var_72A8 = undefined;
  } else {
    level.player scripts\sp\utility::func_65E1("jackal_force_mode");
    level.var_D127.var_72A8 = var_0;
    level.var_D127 _meth_8491(var_0);
  }
}

func_A1DC(var_0) {
  if(!isDefined(var_0) || var_0 == 0) {
    var_0 = 0;
  }

  level.var_A056.var_6F90 = var_0;
}

func_A164(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  if(var_0) {
    level.var_A056.var_1C6C = 0;
  } else {
    level.var_A056.var_1C6C = 1;
  }

  level notify("notify_new_jackal_speed_zone");
}

func_A156(var_0) {
  if(scripts\sp\utility::func_93A6()) {
    return;
  }
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  level.var_A056.targets = scripts\engine\utility::array_removeundefined(level.var_A056.targets);

  if(var_0) {
    level.player scripts\sp\utility::func_65E1("disable_jackal_lockon");

    foreach(var_2 in level.var_A056.targets) {
      var_2 func_105D9();
    }

    setomnvar("ui_jackal_callouts_enabled", 0);
  } else {
    level.player scripts\sp\utility::func_65DD("disable_jackal_lockon");

    foreach(var_2 in level.var_A056.targets) {
      if(var_2.var_AEDF.var_AEEA) {
        var_2 func_105D6();
      }
    }

    setomnvar("ui_jackal_callouts_enabled", 1);
  }

  if(scripts\engine\utility::player_is_in_jackal()) {
    level.player _meth_8490("disable_lockon", var_0);
  }
}

func_A066(var_0) {
  if(!isDefined(var_0)) {}

  self.var_862D = var_0;
  self notify("death");
}

func_A0BE(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  if(var_0) {
    _setsaveddvar("spaceshipAnalogPhysics", 0);
    level.var_A056.var_2CAD = 400;
  } else {
    _setsaveddvar("spaceshipAnalogPhysics", 1);
    level.var_A056.var_2CAD = 0;
  }

  level.player _meth_8490("auto_boost_on", var_0);
}

func_9CC8() {
  if(isDefined(self.var_AEDF)) {
    return 1;
  } else {
    return 0;
  }
}

func_107A2() {
  var_0 = scripts\engine\utility::spawn_tag_origin();
  var_0 func_D2A5();
}

func_D2A5() {
  self.var_4074 = [];
  self.lookahead = scripts\engine\utility::spawn_tag_origin();
  self.lookahead linkto(self, "tag_origin", (2000, 0, 0), (0, 0, 0));
  self.var_BCDA = scripts\engine\utility::spawn_tag_origin();
  self.var_BCDA linkto(self, "tag_origin", (0, 0, 0), (0, 0, 0));
  self.var_B017 = scripts\engine\utility::spawn_tag_origin();
  self.var_B017 linkto(self.lookahead, "tag_origin", (0, 0, 0), (0, 0, 0));
  self.var_4074 = scripts\engine\utility::array_add(self.var_4074, self.var_BCDA);
  self.var_4074 = scripts\engine\utility::array_add(self.var_4074, self.lookahead);
  self.var_4074 = scripts\engine\utility::array_add(self.var_4074, self.var_B017);
  thread func_D29D();
  self.var_CFD9 = spawnStruct();
  self.var_CFD9.var_BC49 = (0, 0, 0);
  self.var_CFD9.var_AFF8 = (0, 0, 0);
  self.var_CFD9.var_1D11 = (0, 0, 0);
  self.var_CFD9.var_11535 = 0;
  self.var_CFD9.var_11533 = 0;
  self.var_CFD9.var_E67D = 0;
  self.var_CFD9.var_B3D1 = 0;
  level.var_D299 = self;
}

func_D29B(var_0, var_1) {
  thread func_D29C(var_0, var_1);
}

func_D29C(var_0, var_1) {
  var_2 = var_1;
  var_3 = self.var_CFD9.var_B3D1;

  while(var_2 > 0) {
    var_4 = scripts\sp\math::func_C097(0, var_1, var_2);
    self.var_CFD9.var_B3D1 = scripts\sp\math::func_6A8E(var_0, var_3, var_4);
    var_2 = var_2 - 0.05;
    wait 0.05;
  }

  self.var_CFD9.var_B3D1 = var_0;
}

func_D2A7() {
  self endon("death");
  func_A38E(35, 3, 0.65, 0.5);
  thread func_D2A4();

  for(;;) {
    self waittill("position_update");
    var_0 = anglesToForward(self.var_114F8);
    var_1 = anglestoright(self.var_114F8);
    var_2 = anglestoup(self.var_114F8);
    var_3 = anglesToForward(self.angles);
    var_4 = anglestoright(self.angles);
    var_5 = anglestoup(self.angles);
    var_6 = scripts\sp\math::func_AB6F(var_3, var_0, self.var_AB72);
    var_7 = scripts\sp\math::func_AB6F(var_4, var_1, self.var_AB72);
    var_8 = scripts\sp\math::func_AB6F(var_5, var_2, self.var_AB72);
    var_9 = distance(self.origin, self.var_1153B);
    var_10 = scripts\sp\math::func_C097(0, self.var_AB78, var_9);
    var_11 = scripts\sp\math::func_6A8E(self.var_AB82, self.var_AB8D, var_10);
    self.origin = scripts\sp\math::func_AB6F(self.origin, self.var_1153B, var_11);
    self.angles = _axistoangles(var_6, var_7, var_8);
    self.var_CFD9 func_D2A2(var_6, var_7, var_8);
    self.var_BCDA unlink();
    self.var_B017 unlink();
    self.var_BCDA.origin = self.origin + self.var_CFD9.var_BC49 * self.var_CFD9.var_B3D1 * self.var_BC68;
    self.var_B017.origin = self.lookahead.origin + self.var_CFD9.var_AFF8 * self.var_CFD9.var_B3D1 * self.var_AFF9;
    var_12 = vectornormalize(self.var_B017.origin - self.var_BCDA.origin);
    self.var_BCDA.angles = _axistoangles(var_12, var_7, var_8) + (0, 0, self.var_CFD9.var_E67D) * self.var_CFD9.var_B3D1;
    self.var_BCDA linkto(self);
    self.var_B017 linkto(self);
  }
}

func_D2A0(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(!isDefined(var_1)) {
    var_1 = (0, 0, 0);
  }

  if(!isDefined(var_2)) {
    self.var_AB78 = 1000;
  } else {
    self.var_AB78 = var_2;
  }

  if(!isDefined(var_3)) {
    self.var_AB82 = 0.05;
  } else {
    self.var_AB82 = var_3;
  }

  if(!isDefined(var_4)) {
    self.var_AB8D = 0.15;
  } else {
    self.var_AB8D = var_4;
  }

  if(!isDefined(var_5)) {
    self.var_AB72 = 0.07;
  } else {
    self.var_AB72 = var_5;
  }

  if(!isDefined(var_6)) {
    self.var_BC68 = 0.05;
  }

  if(!isDefined(var_7)) {
    self.var_AFF9 = 1;
  }

  self.var_11512 = var_0;
  self.var_11514 = var_1;
}

func_D29A(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  self notify("new_follow_blend");
  self endon("new_follow_blend");
  var_9 = var_1;

  if(var_0 != self.var_11512) {
    var_10 = self.var_11512;
    var_11 = var_10 scripts\engine\utility::spawn_tag_origin();
    var_11.angles = var_10.angles;
    self.var_11512 = var_11;
    self.var_2B8E = 1;
  } else {
    var_11 = undefined;
    var_0 = self.var_11512;
    var_10 = self.var_11512;
  }

  if(!isDefined(var_2)) {
    var_12 = self.var_11514;
  } else {
    var_12 = var_2;
  }

  if(!isDefined(var_3)) {
    var_13 = self.var_AB78;
  } else {
    var_13 = var_3;
  }

  if(!isDefined(var_4)) {
    var_14 = self.var_AB82;
  } else {
    var_14 = var_4;
  }

  if(!isDefined(var_5)) {
    var_15 = self.var_AB8D;
  } else {
    var_15 = var_5;
  }

  if(!isDefined(var_6)) {
    var_16 = self.var_AB72;
  } else {
    var_16 = var_6;
  }

  if(!isDefined(var_7)) {
    var_17 = self.var_BC68;
  } else {
    var_17 = var_7;
  }

  if(!isDefined(var_8)) {
    var_18 = self.var_AFF9;
  } else {
    var_18 = var_8;
  }

  var_19 = self.var_11514;
  var_20 = self.var_AB78;
  var_21 = self.var_AB82;
  var_22 = self.var_AB8D;
  var_23 = self.var_AB72;
  var_24 = self.var_BC68;
  var_25 = self.var_AFF9;

  for(;;) {
    var_26 = scripts\sp\math::func_C097(0, var_1, var_9);

    if(isDefined(var_11)) {
      self.var_11512 unlink();
      var_27 = anglesToForward(var_10.angles);
      var_28 = anglestoright(var_10.angles);
      var_29 = anglestoup(var_10.angles);
      var_30 = anglesToForward(var_0.angles);
      var_31 = anglestoright(var_0.angles);
      var_32 = anglestoup(var_0.angles);
      var_33 = scripts\sp\math::func_6A8E(var_30, var_27, var_26);
      var_34 = scripts\sp\math::func_6A8E(var_31, var_28, var_26);
      var_35 = scripts\sp\math::func_6A8E(var_32, var_29, var_26);
      self.var_11512.origin = scripts\sp\math::func_6A8E(var_0.origin, var_10.origin, var_26);
      self.var_11512.angles = _axistoangles(var_33, var_34, var_35);
    }

    self.var_11514 = scripts\sp\math::func_6A8E(var_12, var_19, var_26);
    self.var_AB78 = scripts\sp\math::func_6A8E(var_13, var_20, var_26);
    self.var_AB82 = scripts\sp\math::func_6A8E(var_14, var_21, var_26);
    self.var_AB8D = scripts\sp\math::func_6A8E(var_15, var_22, var_26);
    self.var_AB72 = scripts\sp\math::func_6A8E(var_16, var_23, var_26);
    self.var_BC68 = scripts\sp\math::func_6A8E(var_17, var_24, var_26);
    self.var_AFF9 = scripts\sp\math::func_6A8E(var_18, var_25, var_26);

    if(isDefined(var_11)) {
      self.var_11512 linkto(var_0);
    }

    self notify("target_ent_blend_done");
    wait 0.05;
    var_9 = var_9 - 0.05;

    if(var_26 == 0) {
      break;
    }
  }

  self.var_2B8E = 0;
  func_D2A0(var_0, var_12, var_13, var_14, var_15, var_16, var_17, var_18);
  self notify("target_ent_blend_done");

  if(isDefined(var_11)) {
    var_11 delete();
  }
}

func_D2A4() {
  self endon("death");

  for(;;) {
    if(isDefined(self.var_11512)) {
      var_0 = anglesToForward(self.var_11512.angles);
      var_1 = anglestoright(self.var_11512.angles);
      var_2 = anglestoup(self.var_11512.angles);
      var_3 = var_0 * self.var_11514[0];
      var_4 = var_1 * self.var_11514[1];
      var_5 = var_2 * self.var_11514[2];
      self.var_1153B = self.var_11512.origin + var_3 + var_4 + var_5;
      self.var_114F8 = _axistoangles(var_0, var_1, var_2);
    } else {
      self.var_1153B = self.origin;
      self.var_114F8 = self.angles;
    }

    self notify("position_update");

    if(isDefined(self.var_2B8E) && self.var_2B8E) {
      self waittill("target_ent_blend_done");
      continue;
    }

    wait 0.05;
  }
}

func_D2A2(var_0, var_1, var_2) {
  var_3 = 160;
  var_4 = 160;
  var_5 = 0.03;
  var_6 = 0.1;
  var_7 = 0.13;
  var_8 = 0.13;
  var_9 = 0.7;
  var_10 = 0.95;
  var_11 = 5500;
  var_12 = -5500;
  var_13 = -5500;
  var_14 = 5500;
  var_15 = level.player getsplashtablename();
  var_15 = var_15 * self.var_B3D1;
  var_16 = level.player getnormalizedmovement();
  var_16 = var_16 * self.var_B3D1;
  self.var_11535 = self.var_11535 + var_15[0] * var_3;
  self.var_11533 = self.var_11533 + var_15[1] * var_4;

  if(self.var_11535 > var_11) {
    self.var_11535 = var_11;
  } else if(self.var_11535 < var_12) {
    self.var_11535 = var_12;
  }

  if(self.var_11533 < var_13) {
    self.var_11533 = var_13;
  } else if(self.var_11533 > var_14) {
    self.var_11533 = var_14;
  }

  self.var_11535 = self.var_11535 * var_9;
  self.var_11533 = self.var_11533 * var_9;
  var_17 = self.var_11535 * var_2 + self.var_11533 * var_1;
  self.var_BC49 = scripts\sp\math::func_AB6F(self.var_BC49, var_17, var_5);
  self.var_AFF8 = scripts\sp\math::func_AB6F(self.var_BC49, var_17, var_6);
  var_18 = (self.var_AFF8[1] - self.var_BC49[1]) * var_8;
  self.var_E67D = scripts\sp\math::func_AB6F(self.var_E67D, var_18, var_7);
  self.var_E67D = self.var_E67D * var_10;
}

func_D29D() {
  self waittill("death");

  foreach(var_1 in self.var_4074) {
    if(isDefined(var_1)) {
      var_1 delete();
    }
  }
}

func_A105() {
  level.var_D127 func_430E();
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
  level.var_D127 func_4310();
}

func_4310() {
  thread func_4311();
}

func_4311() {
  self notify("cockpit_light_change");
  self endon("cockpit_light_change");
  wait 0.1;
}

func_A110(var_0) {
  if(!isDefined(var_0)) {
    level.player playSound("jackal_screens_on");
  }

  level.var_D127 func_4323(var_0);
}

func_4323(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  setomnvar("ui_jackal_entity", self);
  setomnvar("ui_jackal_cockpit_screens_noboot", var_0);
  setomnvar("ui_jackal_cockpit_screens", 1);

  if(var_0) {
    var_1 = "cockpit_light_monitor";
  } else {
    var_1 = "cockpit_light_monitor_boot";
  }

  func_A108(var_1);
}

func_A108(var_0) {
  if(isDefined(self.var_430D) && self.var_430D == var_0) {
    return;
  }
  func_A109();
  self.var_430D = var_0;
  scripts\sp\utility::func_75C4(self.var_430D + "_l", "tag_cockpit_light_monitor1", undefined, "player_exit_jackal");
  scripts\sp\utility::func_75C4(self.var_430D + "_mid", "tag_cockpit_light_monitor2", undefined, "player_exit_jackal");
  scripts\sp\utility::func_75C4(self.var_430D + "_r", "tag_cockpit_light_monitor3", undefined, "player_exit_jackal");
}

func_A109() {
  if(isDefined(self.var_430D)) {
    scripts\sp\utility::func_75A0(self.var_430D + "_l", "tag_cockpit_light_monitor1", undefined, "player_exit_jackal");
    scripts\sp\utility::func_75A0(self.var_430D + "_mid", "tag_cockpit_light_monitor2", undefined, "player_exit_jackal");
    scripts\sp\utility::func_75A0(self.var_430D + "_r", "tag_cockpit_light_monitor3", undefined, "player_exit_jackal");
  }

  self.var_430D = undefined;
}

func_A10F() {
  level.var_D127 func_4322();
}

func_4322() {
  setomnvar("ui_jackal_cockpit_screens", 0);
  setomnvar("ui_jackal_entity", undefined);
  level.var_D127 func_A109();
}

func_A10C(var_0) {
  level.var_D127.var_4324 = var_0;
  level.var_D127 func_4320(var_0);
}

func_A10A() {
  level.var_D127.var_4324 = undefined;

  if(!isDefined(level.var_D127.var_431C)) {
    level.var_D127.var_431C = "default";
  }

  level.var_D127 func_4320(level.var_D127.var_431C);
}

func_A10D(var_0, var_1, var_2) {
  level.var_D127 thread func_4321(var_0, var_1, var_2);
}

func_4321(var_0, var_1, var_2) {
  if(isDefined(var_2)) {
    self notify("cancel_request_for" + var_2);
  }

  self endon("cancel_request_for" + var_0);

  if(isDefined(var_1) && isDefined(self.var_431D)) {
    while(self.var_431D == var_1) {
      wait 0.05;
    }
  }

  func_4320(var_0);
}

func_A10B(var_0) {
  level.var_D127.var_431C = var_0;

  if(!isDefined(level.var_D127.var_4324)) {
    level.var_D127 func_4320(var_0);
  }
}

func_4320(var_0) {
  if(!isDefined(var_0)) {
    setomnvar("ui_jackal_cockpit_display", 0);
  }

  if(isDefined(self.var_431D) && self.var_431D == var_0) {
    return;
  }
  switch (var_0) {
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

  self.var_431D = var_0;
}

func_A10E() {}

func_A261(var_0) {
  if(!isDefined(level.var_D127.var_4B23)) {
    if(isDefined(level.var_D127.var_4B22)) {
      level.var_D127 stoploopsound(level.var_D127.var_4B22);
    }

    level.var_D127.var_4B22 = var_0;
    level.var_D127 playLoopSound(level.var_D127.var_4B22);
  } else
    level.var_D127.var_4B22 = var_0;
}

func_1100D(var_0) {
  if(isDefined(var_0)) {
    if(isDefined(level.var_D127.var_4B22) && level.var_D127.var_4B22 == var_0) {
      if(!isDefined(level.var_D127.var_4B23)) {
        level.var_D127 stoploopsound(level.var_D127.var_4B22);
      }

      level.var_D127.var_4B22 = undefined;
    }
  } else {
    if(!isDefined(level.var_D127.var_4B23)) {
      level.var_D127 stoploopsound(level.var_D127.var_4B22);
    }

    level.var_D127.var_4B22 = undefined;
  }
}

func_A262(var_0) {
  if(isDefined(level.var_D127.var_4B22)) {
    level.var_D127 stoploopsound(level.var_D127.var_4B22);
  }

  level.var_D127.var_4B23 = var_0;
  level.var_D127 playLoopSound(level.var_D127.var_4B23);
}

func_1100E() {
  if(isDefined(level.var_D127.var_4B23)) {
    level.var_D127 stoploopsound(level.var_D127.var_4B23);
    level.var_D127.var_4B23 = undefined;

    if(isDefined(level.var_D127.var_4B22)) {
      level.var_D127 playLoopSound(level.var_D127.var_4B22);
    }
  }
}

func_A250(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  if(var_0) {
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

  if(!level.player scripts\sp\utility::func_65DB("disable_jackal_lockon")) {
    setomnvar("ui_jackal_callouts_enabled", 1);
  }

  level.var_A056.targets = scripts\engine\utility::array_removeundefined(level.var_A056.targets);
  var_0 = 9;
  var_1 = 0;
}

func_A226(var_0) {
  level.player notify("jackal_note_hud_off");
  thread func_A227(var_0);
}

func_A22A(var_0) {
  thread func_A22B(var_0);
}

func_A22B(var_0) {
  level.player endon("jackal_note_hud_on");
  level.player endon("jackal_note_hud_off");
  setomnvar("ui_jackal_hud_shutdown", 1);
  setomnvar("ui_hide_hud", 1);
  wait 0.5;
  thread func_A226(var_0);
}

func_A227(var_0) {
  level.player scripts\sp\utility::func_65DD("jackal_hud_on");
  setomnvar("ui_jackal_bootup", 0);
  setomnvar("ui_jackal_callouts_enabled", 0);

  if(!isDefined(var_0) || !var_0) {
    setomnvar("ui_hide_hud", 1);
    level.var_A056 waittill("player_left_jackal");
    setomnvar("ui_hide_hud", 0);
    setomnvar("ui_active_hud", "infantry");
  } else
    setomnvar("ui_hide_hud", 1);
}

func_105DB(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  thread func_11544(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7);
}

func_D920(var_0) {
  self endon("death");

  if(!isDefined(var_0)) {
    var_0 = "null";
  }

  for(;;) {
    wait 0.05;
  }
}

func_11544(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  self notify("new_target_set");
  self endon("new_target_set");
  self.var_AEDF = spawnStruct();
  self.var_AEDF.targeting = 0;
  self.var_AEDF.var_AF21 = 0;
  self.var_AEDF.locked = 0;
  self.var_AEDF.var_11567 = 0;
  self.var_AEDF.var_2A93 = 0;
  self.var_AEDF.type = var_0;
  self.var_AEDF.priority = 0;
  self.var_AEDF.var_933E = 0;
  self.var_AEDF.var_C35F = 0;
  self.var_AEDF.var_AEEA = 1;
  self.var_AEDF.var_38A4 = 0;
  self.var_AEDF.var_C940 = 0;
  self.var_AEDF.var_72A3 = 0;
  self.var_AEDF.callout = 0;
  self.var_AEDF.var_3A5B = 0;

  if(isDefined(var_2)) {
    self.var_AEDF.var_3A5C = var_2;
  } else {
    self.var_AEDF.var_3A5C = "none";
  }

  self.var_AEDF.var_C72C = self.var_AEDF.var_3A5C;

  if(!isDefined(var_3)) {
    self.var_AEDF.var_3782 = "none";
  } else {
    self.var_AEDF.var_3782 = var_3;
  }

  if(!isDefined(var_4)) {
    var_4 = 0;
  }

  if(isDefined(var_6) && var_6) {
    var_8 = 0;
  } else {
    var_8 = 1;
  }

  self _meth_8339(0);
  var_9 = 0;

  if(isDefined(self.script_team)) {
    if(self.script_team == "allies" && isDefined(var_3)) {
      if(!isDefined(var_1)) {
        if(isDefined(self.var_EDB8)) {
          self.name = self.var_EDB8;
        } else {
          scripts\sp\names::func_7B07("unitednations");
        }

        var_1 = self.name;
        var_9 = 1;
      }

      func_A32F();
    } else {
      if(!isDefined(var_1)) {
        var_1 = "JACKAL_ENEMY";
      }

      if(var_0 == "jackal" || var_0 == "ace") {
        self.var_AEDF.var_38A4 = 1;
        self.var_AEDF.var_9405 = 0;
        self.var_AEDF.var_D826 = 0;
      }
    }

    if(isstring(var_1)) {
      self _meth_8307(var_1, &"");
    } else {
      self _meth_8307("", var_1);
    }

    if(var_9) {
      self.var_AEDF.var_3782 = self.var_AEDF.var_3782 + "_unloc";
    }
  }

  if(isDefined(var_5) && var_5) {
    func_A366();
  }

  level.var_A056.targets = scripts\engine\utility::array_removeundefined(level.var_A056.targets);
  level.var_A056.targets = scripts\engine\utility::array_add(level.var_A056.targets, self);
  self _meth_84BE(self.var_AEDF.type);
  func_620B();

  if(var_8) {
    thread func_105D7(var_7);
  }
}

func_105D2() {
  thread func_105D4();
}

func_105D4() {
  self endon("death");

  for(;;) {
    while(!isDefined(level.var_D127) || !isDefined(level.var_D127.var_4BC7) || level.var_D127.var_4BC7 != self) {
      wait 0.05;
    }

    scripts\sp\utility::func_F40A("enemy", 0, 1);

    while(isDefined(level.var_D127) && isDefined(level.var_D127.var_4BC7) && level.var_D127.var_4BC7 == self) {
      wait 0.05;
    }

    self hudoutlinedisable();
  }
}

func_105D3() {
  self endon("stop_highlight_flashes");
  self endon("death");
  var_0 = 3;

  if(isDefined(self.var_A8CB) && gettime() - self.var_A8CB < 10000) {
    if(isDefined(self.var_8EF0)) {
      foreach(var_2 in self.var_8EF0) {
        if(isDefined(var_2)) {
          self.var_A8CB = gettime();
        }
      }
    } else
      self.var_A8CB = gettime();

    return;
  }

  while(var_0 > 0) {
    if(isDefined(self.var_8EF0)) {
      foreach(var_2 in self.var_8EF0) {
        if(isDefined(var_2)) {
          var_2 scripts\sp\utility::func_F40A("enemy", 0, 1);
          var_2.var_A8CB = gettime();
        }
      }
    } else
      scripts\sp\utility::func_F40A("enemy", 0, 1);

    wait 0.3;

    if(isDefined(self.var_8EF0)) {
      foreach(var_2 in self.var_8EF0) {
        if(isDefined(var_2)) {
          var_2 hudoutlinedisable();
        }
      }
    } else
      self hudoutlinedisable();

    wait 0.1;
    var_0--;
  }
}

func_A32F() {
  if(self.var_AEDF.var_C940) {
    return;
  }
  self.var_AEDF.var_C941 = 0;
  level.var_A056.var_C93E = scripts\engine\utility::array_removeundefined(level.var_A056.var_C93E);
  level.var_A056.var_C93E = scripts\engine\utility::array_add(level.var_A056.var_C93E, self);
  self.var_AEDF.var_C940 = 1;
}

func_A2DD() {
  if(!self.var_AEDF.var_C940) {
    return;
  }
  level.var_A056.var_C93E = scripts\engine\utility::array_remove(level.var_A056.var_C93E, self);
  self.var_AEDF.var_C940 = 0;
}

func_A36D() {
  if(self.var_AEDF.priority) {
    return;
  }
  level.var_A056.var_D92C = scripts\engine\utility::array_add(level.var_A056.var_D92C, self);
  self.var_AEDF.priority = 1;
  func_0B76::func_F42C(self.var_AEDF.var_3A5C);

  if(self.var_AEDF.var_72A3) {
    thread func_3777();
  }
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
  if(self.var_AEDF.var_933E) {
    return;
  }
  level.player playSound("jackal_ui_attacker_warning");
  level.var_A056.var_933B = scripts\engine\utility::array_add(level.var_A056.var_933B, self);
  self.var_AEDF.var_933E = 1;
  self.var_AEDF.var_3A5C = "immediate_threat";
  func_0B76::func_F42C(self.var_AEDF.var_3A5C);
}

func_A36A() {
  if(!self.var_AEDF.priority) {
    return;
  }
  self notify("stop_target_priority");
  level.var_A056.var_D92C = scripts\engine\utility::array_remove(level.var_A056.var_D92C, self);
  self.var_AEDF.priority = 0;
  self.var_AEDF.var_3A5C = self.var_AEDF.var_C72C;
  func_0B76::func_F42C(self.var_AEDF.var_3A5C);

  if(self.var_AEDF.var_72A3) {
    func_620A();
  }
}

func_A368() {
  if(!self.var_AEDF.var_933E) {
    return;
  }
  level.var_A056.var_933B = scripts\engine\utility::array_remove(level.var_A056.var_933B, self);
  self.var_AEDF.var_933E = 0;
  self.var_AEDF.var_3A5C = self.var_AEDF.var_C72C;
  func_0B76::func_F42C(self.var_AEDF.var_3A5C);
}

func_A366() {
  if(self.var_AEDF.var_72A3) {
    return;
  }
  self.var_AEDF.var_72A3 = 1;

  if(!self.var_AEDF.priority) {
    func_620A();
  }
}

func_A364() {
  if(!self.var_AEDF.var_72A3) {
    return;
  }
  self.var_AEDF.var_72A3 = 0;

  if(!self.var_AEDF.var_11567) {
    func_5543();
  }
}

func_620B() {
  func_0B76::func_F42C(self.var_AEDF.var_3A5C);
  self.var_AEDF.var_3A5B = 1;
}

func_E046() {
  self _meth_8558();
  self.var_AEDF.var_3A5B = 0;
}

func_620A() {
  func_0B76::func_F42B(self.var_AEDF.var_3782);
  self.var_AEDF.callout = 1;
}

func_5543() {
  if(!self.var_AEDF.var_72A3) {
    self _meth_84A0(0);
    self.var_AEDF.callout = 0;
  }
}

func_105D7(var_0) {
  self notify("juicy_feedback_thread");
  self endon("Death");
  self endon("spaceship_target_remove");
  self endon("juicy_feedback_thread");

  if(isDefined(var_0)) {
    var_1 = var_0;
  } else {
    var_1 = "jackal_impact_target";
  }

  if(self.script_team != "axis") {
    return;
  }
  for(;;) {
    self waittill("damage", var_2, var_3, var_4, var_5, var_6);

    if(!isDefined(self)) {
      return;
    }
    if(isDefined(level.var_D127) && var_3 != level.var_D127) {
      continue;
    }
    if(var_6 == "MOD_PROJECTILE") {
      if(isDefined(level.var_D127) && isDefined(level.var_D127.var_4C15)) {
        _playworldsound(level.var_D127.var_4C15.var_1151E, var_5);
      }

      var_7 = vectornormalize(var_5 - self.origin);
      playFX(scripts\engine\utility::getfx(var_1), var_5, var_7, (0, 0, 1));
    }
  }
}

func_105DA() {
  func_105D8();
  self.var_AEDF = undefined;
  level.var_A056.targets = scripts\engine\utility::array_remove(level.var_A056.targets, self);
  self _meth_8558();
  self notify("spaceship_target_remove");
}

func_105D8() {
  if(!isDefined(self.var_AEDF)) {}

  self.var_AEDF.var_AEEA = 0;
  func_105D9();
}

func_105D9() {
  if(!isDefined(self.var_AEDF)) {}

  if(self.var_AEDF.var_C940) {
    level.var_A056.var_C93E = scripts\engine\utility::array_remove(level.var_A056.var_C93E, self);
  }

  self _meth_84A0(0);
  self _meth_8558();
  self _meth_84C1();
}

func_105D5() {
  if(!isDefined(self.var_AEDF)) {}

  self.var_AEDF.var_AEEA = 1;
  func_105D6();
}

func_105D6() {
  if(level.player scripts\sp\utility::func_65DF("disable_jackal_lockon") && level.player scripts\sp\utility::func_65DB("disable_jackal_lockon")) {
    return;
  }
  if(self.var_AEDF.callout) {
    func_0B76::func_F42B(self.var_AEDF.var_3782);
  }

  if(self.var_AEDF.var_C940) {
    level.var_A056.var_C93E = scripts\engine\utility::array_add(level.var_A056.var_C93E, self);
  } else if(self.var_AEDF.var_3A5B) {
    func_0B76::func_F42C(self.var_AEDF.var_3A5C);
  }

  self _meth_84BE(self.var_AEDF.type);
}

func_7B9B() {
  if(scripts\engine\utility::player_is_in_jackal()) {
    return level.var_D127 gettagorigin("tag_camera");
  } else {
    return level.player getEye();
  }
}

func_7B9F() {
  if(scripts\engine\utility::player_is_in_jackal()) {
    return level.var_D127 gettagangles("tag_camera");
  } else {
    return level.player getEye();
  }
}

func_7BC2() {
  return level.player.var_D409;
}

func_10CD1(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_2)) {
    var_2 = "fly";
  }

  thread func_10CD4(var_0, var_1, var_2, var_3);
  var_0 func_A287(0.1);
  var_0 scripts\engine\utility::delaythread(0.1, ::func_A2DE, 0);
  var_0 scripts\engine\utility::delaythread(1, ::func_A388, 1);
  func_137D6();

  if(scripts\sp\utility::func_93A6()) {
    func_0BD9::func_FA4F();
  }
}

func_10CD2(var_0, var_1) {
  thread func_10CD3(var_0, var_1);
}

func_10CD3(var_0, var_1) {
  if(isDefined(var_1)) {
    if(isstring(var_1)) {
      if(_isstruct(scripts\engine\utility::getstruct(var_1, "targetname"))) {
        var_1 = scripts\engine\utility::getstruct(var_1, "targetname");
      } else if(_isent(getent(var_1, "targetname"))) {
        var_1 = getent(var_1, "targetname");
      }
    }

    var_2 = var_1.origin;

    if(isDefined(var_1.angles)) {
      var_3 = var_1.angles;
    } else {
      var_3 = (0, 0, 0);
    }

    var_0 vehicle_teleport(var_2, var_3);
  }

  var_0 func_0BDB::func_A0F7();
  var_0 func_F448("instant");
  level.var_D127 = var_0;
  var_0 func_0BDB::func_BBE0();
  wait 0.1;
  var_0 showallparts();
  var_0 func_0BDB::func_E073(1);
}

func_10CD4(var_0, var_1, var_2, var_3) {
  var_0 thread func_10CD5();

  while(!isDefined(var_0.var_D161)) {
    wait 0.05;
  }

  var_0 notify("player_jackal_scripting_inited");

  if(var_2 == "runway") {
    var_0 func_F48D("runway");
  } else if(var_2 == "retribution") {
    var_0 func_F48D("retribution");
  } else if(var_2 == "shipcrib_europa_launch") {
    var_0 func_F48D("shipcrib_europa_launch");
  } else {
    var_0 func_F48D("instant_" + var_2);
  }

  if(isDefined(var_3)) {
    var_0 func_F5BD(var_3);
  } else if(var_2 == "land") {
    var_0 func_F5BD("vtol");
  } else if(var_2 == "runway") {
    var_0 func_F5BD("runway");
  } else if(var_2 == "retribution") {
    var_0 func_F5BD("retribution");
  } else if(var_2 == "shipcrib") {
    var_0 func_F5BD("shipcrib");
  } else {
    var_0 func_F5BD("instant");
  }

  if(isDefined(var_1)) {
    if(isstring(var_1)) {
      if(_isstruct(scripts\engine\utility::getstruct(var_1, "targetname"))) {
        var_1 = scripts\engine\utility::getstruct(var_1, "targetname");
      } else if(_isent(getent(var_1, "targetname"))) {
        var_1 = getent(var_1, "targetname");
      }
    }

    var_4 = var_1.origin;

    if(isDefined(var_1.angles)) {
      var_5 = var_1.angles;
    } else {
      var_5 = (0, 0, 0);
    }

    var_0 vehicle_teleport(var_4, var_5);
  }

  level.var_D127 = var_0;
  wait 0.05;
  var_0 func_0BDB::func_F51F();
  var_0 func_F48D("default_landed");
  var_0 func_F5BD("vtol");
}

func_10CD5() {
  self endon("player_jackal_scripting_inited");
  wait 2;
}

func_A38E(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_0)) {
    var_0 = level.var_A056.var_4FEB["spaceshipSpringCameraMaxAngle"];
  }

  if(!isDefined(var_1)) {
    var_1 = level.var_A056.var_4FEB["spaceshipSpringCameraSpringStrength"];
  }

  if(!isDefined(var_2)) {
    var_2 = level.var_A056.var_4FEB["spaceshipSpringCameraSpringStrengthOut"];
  }

  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  thread scripts\sp\utility::func_AB9A("spaceshipSpringCameraMaxAngle", var_0, var_3);
  thread scripts\sp\utility::func_AB9A("spaceshipSpringCameraSpringStrength", var_1, var_3);
  thread scripts\sp\utility::func_AB9A("spaceshipSpringCameraSpringStrengthOut", var_2, var_3);
}

func_A2FC(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = "default";
  }

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  level.var_A056 thread func_A0CF("boost", var_2, var_0, var_1);
}

func_A303(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  level.var_A056 thread func_A0CF("weapKick", "weapKick", var_0, var_1);
}

func_A2FE(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = "default";
  }

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  level.var_A056 thread func_A0CF("boost", var_2, var_0, var_1);
}

func_A301(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = "default";
  }

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  level.var_A056 thread func_A0CF("speed", var_2, var_0, var_1);
}

func_A302(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = "default";
  }

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  level.var_A056 thread func_A0CF("turn", var_2, var_0, var_1);
}

func_A081(var_0, var_1, var_2, var_3) {
  if(!isDefined(level.var_D127)) {
    return;
  }
  if(!isDefined(var_3)) {
    var_4 = level.var_A056.var_BBB9["view_rotate"] func_7CF7();
    var_3 = "view" + var_4;
  }

  thread func_A082(var_0, var_1, var_2, var_3);
}

func_A082(var_0, var_1, var_2, var_3) {
  level.var_A056 notify("view_rotate" + var_3 + "_impulse");
  level.var_A056 endon("view_rotate" + var_3 + "_impulse");
  level.var_D127 endon("player_left_jackal");
  func_A083(var_0, var_1, var_3);
  wait(var_1);
  func_A083((0, 0, 0), var_2, var_3);
}

func_A07E(var_0, var_1, var_2, var_3) {
  if(!isDefined(level.var_D127)) {
    return;
  }
  if(!isDefined(var_3)) {
    var_4 = level.var_A056.var_BBB9["ship_rotate"] func_7CF7();
    var_3 = "rotate" + var_4;
  }

  thread func_A07F(var_0, var_1, var_2, var_3);
}

func_A07F(var_0, var_1, var_2, var_3) {
  level.var_A056 notify("ship_rotate" + var_3 + "_impulse");
  level.var_A056 endon("ship_rotate" + var_3 + "_impulse");
  level.var_D127 endon("player_left_jackal");
  func_A080(var_0, var_1, var_3);
  wait(var_1);
  func_A080((0, 0, 0), var_2, var_3);
}

func_A079(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(level.var_D127)) {
    return;
  }
  var_5 = vectornormalize(level.var_D127.origin - var_0);
  var_6 = var_5 * var_1;

  if(!isDefined(var_4)) {
    var_7 = level.var_A056.var_BBB9["force"] func_7CF7();
    var_4 = "impulse" + var_7;
  }

  thread func_A07A(var_6, var_2, var_3, var_4);
}

func_A07A(var_0, var_1, var_2, var_3) {
  level.var_A056 notify("force" + var_3 + "_impulse");
  level.var_A056 endon("force" + var_3 + "_impulse");
  level.var_D127 endon("player_left_jackal");
  func_A078(var_0, var_1, var_3);
  wait(var_1);
  func_A078((0, 0, 0), var_2, var_3);
}

func_A083(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = "default";
  }

  level.var_A056 thread func_A0D0("view_rotate", var_2, var_0, var_1);
}

func_A080(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = "default";
  }

  level.var_A056 thread func_A0D0("ship_rotate", var_2, var_0, var_1);
}

func_A078(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = "default";
  }

  var_0 = scripts\engine\utility::mph_to_ips(var_0);
  level.var_A056 thread func_A0D0("force", var_2, var_0, var_1);
}

func_A2D7(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 0.0;
  }

  foreach(var_3, var_2 in level.var_A056.var_BBB9["force"].var_3C66) {
    level.var_A056 thread func_A0D0("force", var_3, (0, 0, 0), var_0);
  }
}

func_A0CF(var_0, var_1, var_2, var_3) {
  self notify(var_1);
  self endon(var_1);
  self endon("player_left_jackal");

  if(!isDefined(self.var_BBB9[var_0].var_3C66[var_1])) {
    self.var_BBB9[var_0].var_3C66[var_1] = 1;
  }

  var_4 = self.var_BBB9[var_0].var_3C66[var_1] - var_2;

  if(var_3 <= 0.05) {
    self.var_BBB9[var_0].var_3C66[var_1] = var_2;
    return;
  }

  var_5 = var_4 * (1 / (var_3 + 0.05) * 0.05);

  while(var_3 > 0) {
    var_3 = var_3 - 0.05;
    self.var_BBB9[var_0].var_3C66[var_1] = self.var_BBB9[var_0].var_3C66[var_1] - var_5;
    wait 0.05;
  }

  self.var_BBB9[var_0].var_3C66[var_1] = var_2;

  if(self.var_BBB9[var_0].var_3C66[var_1] == 1) {
    self.var_BBB9[var_0].var_3C66 = scripts\sp\utility::func_22B2(self.var_BBB9[var_0].var_3C66, var_1);
  }
}

func_7CF7() {
  self.var_1189B++;

  if(self.var_1189B > 100) {
    self.var_1189B = 0;
  }

  return self.var_1189B;
}

func_A0D0(var_0, var_1, var_2, var_3) {
  self notify(var_0 + var_1);
  self endon(var_0 + var_1);
  self endon(var_0 + var_1 + "_impulse");
  self endon("player_left_jackal");

  if(!isDefined(self.var_BBB9[var_0].var_3C66[var_1])) {
    self.var_BBB9[var_0].var_3C66[var_1] = (0, 0, 0);
  }

  var_4 = self.var_BBB9[var_0].var_3C66[var_1];

  if(var_3 <= 0.05) {
    func_A325(var_0, var_1, var_2);
    return;
  }

  var_5 = var_2 - var_4;
  var_6 = var_5 * (1 / (var_3 + 0.05) * 0.05);

  while(var_3 > 0) {
    var_3 = var_3 - 0.05;
    self.var_BBB9[var_0].var_3C66[var_1] = self.var_BBB9[var_0].var_3C66[var_1] + var_6;
    wait 0.05;
  }

  func_A325(var_0, var_1, var_2);
}

func_A325(var_0, var_1, var_2) {
  if(length(var_2) == 0) {
    self.var_BBB9[var_0].var_3C66 = scripts\sp\utility::func_22B3(self.var_BBB9[var_0].var_3C66, [var_1]);
  } else {
    self.var_BBB9[var_0].var_3C66[var_1] = var_2;
  }
}

func_E0A1() {
  level.var_A056.var_12F96 = scripts\sp\utility::func_22B9(level.var_A056.var_12F96);
  level.var_A056.var_12F96 = scripts\engine\utility::array_removeundefined(level.var_A056.var_12F96);
}

func_137D6() {
  level.player scripts\sp\utility::func_65E3("flag_player_is_flying");
}

func_137CF() {
  level.player endon("death");

  if(isalive(level.player) && level.player scripts\sp\utility::func_65DF("flag_player_has_jackal")) {
    level.player scripts\sp\utility::func_65E3("flag_player_has_jackal");
  }
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
    var_0 = level.player _meth_8473();

    if(!isDefined(var_0)) {
      break;
    }
    wait 0.05;
  }
}

func_137DB() {
  for(;;) {
    if(func_A2A7()) {
      return;
    } else {
      wait 0.05;
    }
  }
}

func_137D9() {
  for(;;) {
    if(!func_A2A7()) {
      return;
    } else {
      wait 0.05;
    }
  }
}

func_13797() {
  var_0 = 0;

  for(;;) {
    var_1 = level.player getnormalizedmovement();
    var_2 = var_1[0] + var_1[1];

    if(level.player _meth_8439()) {
      if(var_2 > 0.3 && !var_0) {
        break;
      }
      var_0 = 1;
    } else
      var_0 = 0;

    wait 0.05;
  }
}

func_137A9() {
  if(self.var_99F5.var_BBF1) {
    return;
  }
  for(;;) {
    self waittill("mountable", var_0);

    if(var_0) {
      return;
    }
  }
}

waittill_nodialogueplaying() {
  if(!self.var_99F5.var_BBF1) {
    return;
  }
  for(;;) {
    self waittill("mountable", var_0);

    if(!var_0) {
      return;
    }
  }
}

func_104A6(var_0) {
  if(var_0 == self.var_99F5.var_BBF1) {
    return;
  }
  self.var_99F5.var_BBF1 = var_0;

  if(var_0) {
    thread func_0BD9::func_1049C();
    self notify("mountable", var_0);
  } else {
    thread func_0BD9::func_1049B();
    self notify("mountable", var_0);
  }
}

func_DE6D() {
  if(self.var_99F5.var_BBF1) {
    thread func_0BD9::func_1049C();
  }
}

func_CF50(var_0) {
  func_E0A1();

  foreach(var_2 in level.var_A056.var_12F96) {
    var_2 func_104A6(var_0);
  }
}

func_104A0() {
  return isDefined(self.var_1912) && self.var_1912;
}

func_7A5B(var_0) {
  if(scripts\engine\utility::player_is_in_jackal()) {
    return var_0;
  } else {
    return var_0 + "_grnd";
  }
}

func_9BDE() {
  if(isDefined(self.classname) && self.classname == "script_vehicle_jackal_fake_enemy") {
    return 1;
  } else {
    return 0;
  }
}

func_9CF5() {
  if(isDefined(self.spawnflags) && self.spawnflags & 1) {
    return 1;
  } else {
    return 0;
  }
}

func_A2A7() {
  if(isDefined(self.owner) && self.owner == level.player) {
    return 1;
  } else {
    return 0;
  }
}

func_13675(var_0) {
  self endon("death");
  self endon("entitydeleted");
  self endon("fakedeath");
  wait(var_0);
}

func_A06A(var_0) {
  level notify("notify_new_landing_state");
  level endon("notify_new_landing_state");

  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  if(var_0) {
    level.player scripts\sp\utility::func_65E1("flag_player_landing_enabled");
  } else {
    level.player scripts\sp\utility::func_65DD("flag_player_landing_enabled");
  }

  foreach(var_2 in level.var_A056.var_1632) {
    foreach(var_4 in var_2.lights) {
      if(var_0) {
        if(var_2.enabled) {
          playFXOnTag(scripts\engine\utility::getfx("landing_pad_lights"), var_4, "tag_origin");
        }

        continue;
      }

      _killfxontag(scripts\engine\utility::getfx("landing_pad_lights"), var_4, "tag_origin");
    }

    if(!var_0) {
      var_2 func_0BDB::func_4130();
    }
  }
}

func_A24B(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  var_2 = [];

  foreach(var_4 in level.var_A056.var_A82D) {
    if(isDefined(var_4.script_noteworthy) && var_4.script_noteworthy == var_0) {
      var_2 = scripts\engine\utility::array_add(var_2, var_4);
    }
  }

  foreach(var_4 in var_2) {
    func_6211(var_4, var_1);
  }
}

func_A24A(var_0) {
  var_1 = [];

  foreach(var_3 in level.var_A056.var_A82D) {
    if(isDefined(var_3.script_noteworthy) && var_3.script_noteworthy == var_0) {
      var_1 = scripts\engine\utility::array_add(var_1, var_3);
    }
  }

  foreach(var_3 in var_1) {
    level.var_A056.var_A82D = scripts\engine\utility::array_remove(level.var_A056.var_A82D, var_3);

    if(scripts\engine\utility::array_contains(level.var_A056.var_1632, var_3)) {
      level.var_A056.var_1632 = scripts\engine\utility::array_remove(level.var_A056.var_1632, var_3);
    }

    var_3 func_0BDB::func_4130();
    var_3.var_1270F delete();

    foreach(var_7 in var_3.lights) {
      var_7 delete();
    }
  }
}

func_6211(var_0, var_1) {
  if(var_0.enabled != var_1) {
    var_0.enabled = var_1;

    if(var_1) {
      level.var_A056.var_1632 = scripts\engine\utility::array_add(level.var_A056.var_1632, var_0);
      _objective_add(scripts\sp\utility::func_C264("OBJ_VTOL_LAND"), "invisible");
      objective_onentity(scripts\sp\utility::func_C264("OBJ_VTOL_LAND"), var_0.tag_origin);
      objective_state(scripts\sp\utility::func_C264("OBJ_VTOL_LAND"), "current");
    } else {
      level.var_A056.var_1632 = scripts\engine\utility::array_remove(level.var_A056.var_1632, var_0);
      var_0 func_0BDB::func_4130();
      objective_delete(scripts\sp\utility::func_C264("OBJ_VTOL_LAND"));
    }

    foreach(var_3 in var_0.lights) {
      if(var_1 && level.player scripts\sp\utility::func_65DB("flag_player_landing_enabled")) {
        playFXOnTag(scripts\engine\utility::getfx("landing_pad_lights"), var_3, "tag_origin");
        continue;
      }

      _killfxontag(scripts\engine\utility::getfx("landing_pad_lights"), var_3, "tag_origin");
    }
  }
}

func_137F6(var_0, var_1, var_2, var_3) {
  self endon("entitydeleted");
  var_0 endon("entitydeleted");

  if(!isDefined(var_3)) {
    var_3 = 0.1;
  }

  var_4 = "waittill_point_timeout";
  var_5 = "point_success";
  self endon(var_4);
  thread func_1358E(var_2, var_4, var_5);

  while(!func_9C87(var_0, var_1)) {
    wait(var_3);
  }

  self notify(var_5);
}

func_1358E(var_0, var_1, var_2) {
  self endon(var_2);
  wait(var_0);
  self notify(var_1);
}

func_9C87(var_0, var_1) {
  var_2 = undefined;

  if(_isent(var_0) || _isstruct(var_0)) {
    var_2 = var_0.origin;
  } else if(!_isvector(var_0)) {} else
    var_2 = var_0;

  var_3 = vectordot(vectornormalize(var_2 - self.origin), anglesToForward(self.angles));

  if(var_3 > var_1) {
    return 1;
  } else {
    return 0;
  }
}

func_9B92(var_0, var_1) {
  var_2 = undefined;

  if(_isent(var_0) || _isstruct(var_0)) {
    var_2 = var_0.origin;
  } else if(!_isvector(var_0)) {} else
    var_2 = var_0;

  var_3 = distance(self.origin, var_2);

  if(var_3 < var_1) {
    return 1;
  } else {
    return 0;
  }
}

func_1079F(var_0, var_1) {
  var_0 = getent(var_0, "targetname");

  if(!isDefined(var_0)) {}

  var_2 = var_0 scripts\sp\utility::func_10808();

  if(isDefined(var_1)) {
    var_2 func_1162F(var_1);
  }

  return var_2;
}

func_1162F(var_0) {
  var_1 = scripts\engine\utility::getstruct(var_0, "targetname");

  if(!isDefined(var_1)) {}

  if(!isDefined(var_1.angles)) {
    var_1.angles = (0, 0, 0);
  }

  self vehicle_teleport(var_1.origin + (0, 0, 70), var_1.angles);
  self _meth_8455(var_1.origin + (0, 0, 70), 1, var_1.angles);
}

func_10749() {
  self.var_BC85 = scripts\engine\utility::spawn_tag_origin();
  self.var_AFEE = scripts\engine\utility::spawn_tag_origin();
  self.var_4074 = scripts\engine\utility::array_combine(self.var_4074, [self.var_BC85, self.var_AFEE]);
}

func_E04B() {
  if(isDefined(self.var_BC85)) {
    self.var_BC85 delete();
  }

  if(isDefined(self.var_AFEE)) {
    self.var_AFEE delete();
  }
}

func_7AB7() {
  if(!isDefined(level.var_D127)) {
    return;
  }
  return level.var_D127.var_AFEE;
}

func_7AFB() {
  if(!isDefined(level.var_D127)) {
    return;
  }
  return level.var_D127.var_BC85;
}

func_7B9E() {
  if(!isDefined(level.var_D127)) {
    return 0;
  } else {
    return length(level.var_D127.spaceship_vel);
  }
}

func_7B9C() {
  if(!isDefined(level.var_D127)) {
    return 0;
  } else {
    var_0 = rotatevectorinverted(level.var_D127.spaceship_vel, level.var_D127.angles);
    return var_0[0];
  }
}

func_D16C(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = "moveto";
  var_7 = func_7AFB();
  var_7 func_D960(var_0, var_5);
  func_D155(var_7, var_1, var_2, var_3, var_4, var_6);
}

func_D165(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = "lookat";
  var_7 = func_7AB7();
  var_7 func_D960(var_0, var_5);
  func_D155(var_7, var_1, var_2, var_3, var_4, var_6);
}

func_D155(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(isDefined(var_4) && var_4) {
    var_6 = "absolute";
  } else {
    var_6 = "desires";
  }

  level.var_A056.var_11B0D[var_5][var_6] = 1;
  level.var_D127 notify(var_5 + "_started");
  level.player _meth_8462(var_0, var_5, var_6, var_1, var_3);
  level.player _meth_8462(var_0, var_5, var_6 + "_player", var_2, var_3);

  if(var_1 == 0 && var_2 == 1) {
    thread func_D156(var_5, var_6, var_3);
  }
}

func_D156(var_0, var_1, var_2) {
  level.var_D127 endon(var_0 + "_started");
  wait(var_2);
  level.var_A056.var_11B0D[var_0][var_1] = 0;

  if(level.var_A056.var_11B0D[var_0]["absolute"] == 0 && level.var_A056.var_11B0D[var_0]["desires"] == 0 && level.var_A056.var_11B0D[var_0]["link"] == 0) {
    level.player _meth_8463(var_0);
  }
}

func_D164(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  level.var_A056.var_11B0D["moveto"]["link"] = 1;
  level.var_A056.var_11B0D["lookat"]["link"] = 1;
  level.var_D127 notify("moveto_started");
  level.var_D127 notify("lookat_started");
  level.var_D127 endon("linktoblend_started");
  level.player _meth_8462(var_0, "orient", "time", 1, var_1);
  level.player _meth_8462(var_0, "orient", "time_player", 0, var_1);
  level.player _meth_8462(var_0, "moveto", "time", 1, var_1);
  level.player _meth_8462(var_0, "moveto", "time_player", 0, var_1);
  level.var_A056.var_AD1D = var_0;
}

func_D190(var_0) {
  if(!isDefined(level.var_A056.var_AD1D)) {
    return;
  }
  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  thread func_D191(var_0, "moveto", "moveto");
  thread func_D191(var_0, "lookat", "orient");
  wait(var_0);
  level.var_A056.var_AD1D = undefined;
}

func_D191(var_0, var_1, var_2) {
  level.var_D127 endon(var_1 + "_started");
  level.var_D127 endon("linktoblend_started");
  level.player _meth_8462(level.var_A056.var_AD1D, var_2, "time", 0, var_0);
  level.player _meth_8462(level.var_A056.var_AD1D, var_2, "time_player", 1, var_0);
  wait(var_0);
  level.var_A056.var_11B0D["moveto"]["link"] = 0;
  level.var_A056.var_11B0D["lookat"]["link"] = 0;

  if(level.var_A056.var_11B0D[var_1]["absolute"] == 0 && level.var_A056.var_11B0D[var_1]["desires"] == 0 && level.var_A056.var_11B0D[var_1]["link"] == 0) {
    level.player _meth_8463(var_1);
  }
}

func_D960(var_0, var_1) {
  if(_isvector(var_0)) {
    if(self getteamflagcount()) {
      self unlink();
    }

    self dontinterpolate();
    self.origin = var_0;
  } else if(_isstruct(var_0)) {
    if(self getteamflagcount()) {
      self unlink();
    }

    self dontinterpolate();
    self.origin = var_0.origin;
  } else if(_isent(var_0)) {
    if(!isDefined(var_1)) {
      var_1 = _getpartname(var_0.model, 0);
    }

    self linkto(var_0, var_1, (0, 0, 0), (0, 0, 0));
  }
}

func_A2B0(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_2)) {
    var_2 = 0.2;
  }

  if(!isDefined(var_3)) {
    var_3 = 0.2;
  }

  level.player _meth_8489("body", var_0, var_2, var_1);
  wait(getanimlength(var_0) - var_3);
  level.player _meth_8489("blendout", var_0, var_3, var_1);
}

func_2B74(var_0, var_1, var_2, var_3, var_4, var_5) {
  self notify("stop_blended_links");
  self endon("stop_blended_links");

  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  var_6 = var_2 * var_3;

  if(!isDefined(var_4)) {
    var_4 = _getpartname(var_0.model, 0);
  }

  if(!isDefined(var_5)) {
    var_5 = _getpartname(var_1.model, 0);
  }

  while(var_6 < var_2) {
    var_7 = var_6 / var_2;
    var_8 = var_0 gettagangles(var_4);
    var_9 = var_1 gettagangles(var_5);
    var_10 = anglestoaxis(var_8);
    var_11 = anglestoaxis(var_9);
    var_12 = var_11["forward"] * var_7 + var_10["forward"] * (1 - var_7);
    var_13 = var_11["right"] * var_7 + var_10["right"] * (1 - var_7);
    var_14 = var_11["up"] * var_7 + var_10["up"] * (1 - var_7);
    var_15 = _axistoangles(var_12, var_13, var_14);
    var_16 = var_0 gettagorigin(var_4);
    var_17 = var_1 gettagorigin(var_5);
    var_18 = var_17 * var_7 + var_16 * (1 - var_7);

    if(var_7 < 0.5) {
      self linkto(var_0, var_4, rotatevectorinverted(var_18 - var_16, var_8), var_15 - var_8);
    } else {
      self linkto(var_1, var_5, rotatevectorinverted(var_18 - var_17, var_9), var_15 - var_9);
    }

    wait 0.05;
    var_6 = var_6 + 0.05;
  }

  scripts\engine\utility::waitframe();

  if(isDefined(self.start)) {
    self.start delete();
  }
}

func_13DE7(var_0, var_1) {
  if(var_0[var_1] > 180) {
    var_2 = var_0[var_1] - 360;
  } else if(var_0[var_1] < -180) {
    var_2 = var_0[var_1] + 360;
  } else {
    var_2 = var_0[var_1];
  }

  return var_2;
}

func_12D71(var_0, var_1, var_2) {
  var_3 = var_0[var_2];
  var_4 = var_1[var_2];

  for(;;) {
    if(var_3 - var_4 > 180) {
      var_3 = var_3 - 360;
      continue;
    }

    if(var_3 - var_4 < -180) {
      var_3 = var_3 + 360;
      continue;
    }

    return var_3;
  }
}

func_C6FC(var_0, var_1, var_2) {
  self.angles = func_1E83(var_0.angles, var_1.angles, var_2);
}

func_1E83(var_0, var_1, var_2) {
  var_3 = anglesToForward(var_1);
  var_4 = anglesToForward(var_0);
  var_5 = anglestoup(var_1);
  var_6 = anglestoup(var_0);
  var_7 = anglestoright(var_1);
  var_8 = anglestoright(var_0);
  var_9 = var_4 * (1 - var_2) + var_3 * var_2;
  var_10 = var_8 * (1 - var_2) + var_7 * var_2;
  var_11 = var_6 * (1 - var_2) + var_5 * var_2;
  return _axistoangles(var_9, var_10, var_11);
}

func_1994(var_0, var_1, var_2, var_3, var_4, var_5) {
  self._blackboard.var_7235.target = var_0;
  self._blackboard.var_7235.offset = var_1;
  self._blackboard.var_7235.var_7237 = 0;
  self notify("bt_state_changed");

  if(isDefined(var_2)) {
    self._blackboard.var_7235.var_98F9 = var_2;
    self._blackboard.var_7235.var_98FE = var_3;
    self._blackboard.var_7235.var_C760 = var_4;
    self._blackboard.var_7235.var_C765 = var_5;
  } else {
    self._blackboard.var_7235.var_98F9 = undefined;
    self._blackboard.var_7235.var_98FE = undefined;
    self._blackboard.var_7235.var_C760 = undefined;
    self._blackboard.var_7235.var_C765 = undefined;
  }
}

func_19B7() {
  self._blackboard.var_7235.target = undefined;
  self._blackboard.var_7235.offset = undefined;
}

func_199D(var_0, var_1, var_2, var_3, var_4, var_5) {
  self notify("new_follow_offset");
  thread func_A254(var_0, var_1, var_2, var_3, var_4, var_5);
}

func_A254(var_0, var_1, var_2, var_3, var_4, var_5) {
  self endon("death");
  self endon("entitydeleted");
  self endon("new_follow_offset");
  var_6 = self._blackboard.var_7235.offset;
  var_7 = self._blackboard.var_7235.var_98F9;
  var_8 = self._blackboard.var_7235.var_98FE;
  var_9 = self._blackboard.var_7235.var_C760;
  var_10 = self._blackboard.var_7235.var_C765;

  for(var_11 = var_0; var_11 > 0; var_11 = var_11 - 0.05) {
    var_12 = var_11 / var_0;
    var_13 = scripts\sp\math::func_6A8E(var_1, var_6, var_12);
    var_14 = scripts\sp\math::func_6A8E(var_2, var_7, var_12);
    var_15 = scripts\sp\math::func_6A8E(var_3, var_8, var_12);
    var_16 = scripts\sp\math::func_6A8E(var_4, var_9, var_12);
    var_17 = scripts\sp\math::func_6A8E(var_5, var_10, var_12);
    func_A255(var_13, var_14, var_15, var_16, var_17);
    wait 0.05;
  }

  func_A255(var_1, var_2, var_3, var_4, var_5);
}

func_A255(var_0, var_1, var_2, var_3, var_4) {
  self._blackboard.var_7235.offset = var_0;
  self._blackboard.var_7235.var_7237 = 0;
  self._blackboard.var_7235.var_98F9 = var_1;
  self._blackboard.var_7235.var_98FE = var_2;
  self._blackboard.var_7235.var_C760 = var_3;
  self._blackboard.var_7235.var_C765 = var_4;
}

func_A372(var_0) {
  var_1 = _getcsplineid(var_0);
  var_2 = getcsplinepointposition(var_1, 0);
  self vehicle_teleport(var_2, self.angles);
  return var_1;
}

func_A373(var_0, var_1) {
  var_2 = func_A372(var_0);
  thread func_A1EF(var_2, var_1);
}

func_A1EF(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_1)) {
    var_5 = func_1996();
    var_1 = var_5.speed;
  }

  if(!isDefined(var_4)) {
    var_4 = 1.0;
  }

  if(!isDefined(var_2)) {
    var_2 = var_4 * scripts\engine\utility::mph_to_ips(var_1);
  }

  func_A1ED(var_0, var_1, var_2, var_3);
  func_A342(var_0, var_4, var_3);
}

func_A1F3(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_4)) {
    var_4 = 1.0;
  }

  if(!isDefined(var_3)) {
    var_3 = 2048;
  }

  func_A1F2(var_0, var_1, var_2, var_3);
  func_A342(var_0, var_4, 1);
}

func_A1F0(var_0, var_1, var_2, var_3, var_4) {
  func_1981();

  if(!isDefined(var_3)) {
    var_3 = 0.2;
  }

  var_5 = _getcsplineid(var_0);
  var_6 = (var_4, 0, 0);
  var_6 = rotatevector(var_6, self.angles);
  var_7 = self.origin + var_6;
  var_8 = _calccsplineclosestpoint(var_5, var_7);
  self _meth_8455(var_8);

  if(!isDefined(var_2)) {
    var_2 = 384.0;
  }

  self setneargoalnotifydist(var_2);

  if(isDefined(var_1)) {
    self _meth_845F(var_1);
  }

  self waittill("near_goal");
  func_1981();
  self _meth_8479(var_5);
  self _meth_847B(var_3, var_7);
  self.var_10A43 = var_5;
  self waittill("near_goal");
  func_0C24::func_10A44(var_5);
}

func_A1ED(var_0, var_1, var_2, var_3) {
  if(isDefined(self._blackboard)) {
    func_1981();
  }

  if(isDefined(var_3) && var_3) {
    var_4 = _calccsplineclosestpoint(var_0, self.origin);
  } else {
    var_4 = getcsplinepointposition(var_0, 0);
  }

  self _meth_8455(var_4);

  if(!isDefined(var_2)) {
    var_2 = 384.0;
  }

  self setneargoalnotifydist(var_2);

  if(isDefined(var_1)) {
    self _meth_845F(var_1);
  }

  self waittill("near_goal");
}

func_A1F2(var_0, var_1, var_2, var_3) {
  if(isDefined(self._blackboard)) {
    func_1981();
  }

  var_4 = getcsplinepointposition(var_0, var_1);
  self _meth_8455(var_4);

  if(!isDefined(var_3)) {
    var_3 = 384.0;
  }

  self setneargoalnotifydist(var_3);

  if(isDefined(var_2)) {
    self _meth_845F(var_2);
  }

  self waittill("near_goal");
}

func_A112(var_0, var_1, var_2, var_3) {
  thread func_A113(var_0, var_1, var_2, var_3);
}

func_A113(var_0, var_1, var_2, var_3) {
  if(isDefined(level.var_D127.var_5F6F)) {
    return;
  }
  if(!isDefined(var_1)) {
    var_1 = 3;
  }

  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  if(!isDefined(var_3)) {
    var_3 = 0.5;
  }

  var_4 = [var_2, var_0, var_1, gettime(), var_3];
  func_A104(var_4);

  if(!isDefined(level.var_D127.var_432D)) {
    thread func_A115();
  }
}

func_A115() {
  level.var_D127.var_432D = scripts\engine\utility::spawn_script_origin();
  level.var_D127.var_432D linkto(level.var_D127, "tag_origin", (0, 0, 0), (0, 0, 0));

  while(level.var_A056.var_432C.size > 0) {
    var_0 = level.var_A056.var_432C[0];
    level.var_A056.var_432C = scripts\sp\utility::array_remove_index(level.var_A056.var_432C, 0);
    level.player scripts\sp\utility::func_65E8("disable_jackal_cockpit_VO");

    if(gettime() - var_0[3] > var_0[2] * 1000) {
      continue;
    }
    level.player scripts\sp\utility::func_65E1("jackal_cockpit_VO");
    level.var_A056.var_4B57 = var_0[0];
    level.var_D127.var_432D func_A114(var_0[1]);
    level.player scripts\sp\utility::func_65DD("jackal_cockpit_VO");
    level.var_A056.var_4B57 = -999999;

    if(level.var_A056.var_432C.size > 0) {
      wait(level.var_A056.var_432C[0][4]);
    }
  }

  level.var_D127.var_432D delete();
}

func_A114(var_0) {
  self endon("jackal_cockpit_VO_interupt");
  self playSound(var_0, "sounddone");
  self waittill("sounddone");
}

func_A104(var_0) {
  var_1 = 0;

  for(;;) {
    if(level.var_A056.var_432C.size == var_1) {
      level.var_A056.var_432C[var_1] = var_0;
      break;
    }

    if(var_0[0] > level.var_A056.var_432C[var_1][0]) {
      level.var_A056.var_432C = scripts\engine\utility::array_insert(level.var_A056.var_432C, var_0, var_1);
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

func_A1F4(var_0, var_1, var_2, var_3) {
  var_4 = scripts\engine\utility::getstruct(var_0, "targetname");

  if(isDefined(var_3) && var_3) {
    var_5 = var_4.angles;
  } else {
    var_5 = undefined;
  }

  func_A1EC(var_4.origin, var_1, var_2, var_5);
}

func_A1EC(var_0, var_1, var_2, var_3) {
  self endon("death");
  self endon("delete");

  if(!isDefined(var_2)) {
    var_2 = 384.0;
  }

  func_1981();

  if(isDefined(var_3)) {
    self _meth_8455(var_0, var_1, var_3);
  } else {
    self _meth_8455(var_0, var_1);
  }

  self setneargoalnotifydist(var_2);

  if(var_1) {
    self waittill("goal");
  } else {
    self waittill("near_goal");
  }
}

func_1981() {
  if(!isDefined(self._blackboard)) {
    return;
  }
  if(self._blackboard.var_EF72 && !isDefined(self.var_1FCE)) {
    return;
  }
  if(!self._blackboard.var_EF72) {
    self.var_1FCE = 1;
  }

  self._blackboard.var_3F28 = undefined;
  self notify("jackal_animscripteduntilgoal");
  func_19A9();
  thread func_1982();
}

func_1982() {
  self endon("jackal_animscripteduntilgoal");
  self waittill("near_goal");
  func_1988();
  self.var_1FCE = undefined;
}

func_19A9() {
  self._blackboard.var_EF72 = 1;
  self.bt.var_3F28 = undefined;
}

func_1988() {
  self._blackboard.var_EF72 = 0;
}

func_19A2() {
  scripts\asm\asm_bb::bb_setanimscripted();
  func_19A9();
}

func_1986() {
  scripts\asm\asm_bb::bb_clearanimscripted();
  func_1988();
}

func_19B1(var_0) {
  self._blackboard.var_90EA = var_0;
}

func_19B0(var_0) {
  self._blackboard.var_E1AC = var_0;

  if(var_0 == "hover" || var_0 == "fly") {
    self _meth_8491(var_0);
    func_0C21::func_20DD();
  }
}

func_1984(var_0) {
  func_19B5(var_0);
  func_1980(0.5);
  wait 0.05;
  func_19AE("shoot_single_burst");
  self waittill("firemode changed");
  func_198A();
  func_1980();
}

func_6E8C(var_0) {
  if(isDefined(level.var_D127) && var_0 == level.var_D127) {
    thread func_6E92();
  }

  scripts\engine\utility::waittill_either("missile_hit", "burnt_out");
  self.active = 0;
  self notify("pos_updated");
  stopFXOnTag(self.fx, self, "tag_origin");

  if(isDefined(var_0) && scripts\engine\utility::array_contains(var_0.var_6E9C.var_12B86, self)) {
    var_0.var_6E9C.var_12B86 = scripts\engine\utility::array_remove(var_0.var_6E9C.var_12B86, self);
  }

  wait 0.05;
  self delete();
}

func_6E92() {
  self endon("burnt_out");
  self waittill("missile_hit");
  self playSound("jackal_flare_hit_missile");
}

func_19AF(var_0, var_1, var_2) {
  if(!isDefined(self.var_6E9C)) {
    return;
  }
  if(isDefined(var_0)) {
    var_0 = clamp(var_0, 0, 100);
    self.var_6E9C.var_3C37 = var_0;
  }

  if(isDefined(var_1)) {
    var_1 = clamp(var_1, 0, 100);
    self.var_6E9C.var_3C38 = var_1;
  }

  if(isDefined(var_2)) {
    var_2 = clamp(var_2, 0, 100);
    self.var_6E9C.var_3C36 = var_2;
  }
}

func_19AE(var_0) {
  if(self._blackboard.var_6D77 == var_0) {
    return;
  }
  self._blackboard.var_6D77 = var_0;
  self notify("stop sound" + self._blackboard.var_6D83);
  self notify("firemode changed");

  if(scripts\sp\utility::func_65DF("jackal_firing")) {
    scripts\sp\utility::func_65DD("jackal_firing");
  }
}

func_1989() {
  self._blackboard.var_C705 = undefined;
  self._blackboard.var_C702 = undefined;
}

func_19B2(var_0, var_1) {
  self._blackboard.var_C705 = var_0;

  if(var_0 == "face angle") {
    self._blackboard.var_C702 = var_1;
    self goon_spawners(var_0, var_1);
    return;
  }

  self._blackboard.var_C702 = undefined;
  self goon_spawners(var_0);
}

func_19B5(var_0) {
  self._blackboard.var_11577 = var_0;
  func_0C1B::func_12E3A();
}

func_198A() {
  self._blackboard.var_11577 = undefined;
}

func_19A0(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  if(var_0) {
    func_19A2();
  } else {
    func_1986();
  }
}

func_19AB(var_0, var_1, var_2, var_3) {
  if(isDefined(self._blackboard)) {
    func_19AD(var_0, var_1, var_2, var_3);
    func_19AC(var_0, var_1, var_2, var_3);
  } else
    self _meth_845F(var_0, var_1, var_2, var_3);
}

func_19AC(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_0)) {
    self._blackboard.var_23A4 = func_0C21::func_9536();
  } else {
    self._blackboard.var_23A4.speed = var_0;

    if(isDefined(var_1)) {
      self._blackboard.var_23A4.var_1545 = var_1;
    }

    if(isDefined(var_2)) {
      self._blackboard.var_23A4.var_1E91 = var_2;
    }

    if(isDefined(var_3)) {
      self._blackboard.var_23A4.var_1E71 = var_3;
    }
  }

  func_0C21::func_20DD();
}

func_19AD(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_0)) {
    self._blackboard.var_1113B = func_0C21::func_976D();
  } else {
    self._blackboard.var_1113B.speed = var_0;

    if(isDefined(var_1)) {
      self._blackboard.var_1113B.var_1545 = var_1;
    }

    if(isDefined(var_2)) {
      self._blackboard.var_1113B.var_1E91 = var_2;
    }

    if(isDefined(var_3)) {
      self._blackboard.var_1113B.var_1E71 = var_3;
    }
  }

  func_0C21::func_20DD();
}

func_1996() {
  return func_0C21::_meth_814A();
}

func_ACE8(var_0, var_1) {
  while(!isDefined(level.var_D127)) {
    wait 0.05;
  }

  if(!isDefined(var_0)) {
    var_0 = (1, 1, 1);
  }

  self endon("stop_line");

  for(;;) {
    if(!isDefined(self)) {
      break;
    }
    if(isDefined(var_1)) {
      var_2 = self gettagorigin(var_1);
    } else {
      var_2 = self.origin;
    }

    wait 0.05;
  }
}

func_19A7(var_0, var_1, var_2, var_3) {
  if(!isDefined(self.var_B8AE)) {
    self.var_B8AE = spawnStruct();
  }

  var_0 = max(512, var_0);
  self.var_B8AE.var_DCCA = var_0;
  self.var_B8AE.var_B48B = var_1;
  self.var_B8AE.var_B758 = var_2;

  if(isDefined(var_3)) {
    self.var_B8AE.var_B4C9 = var_3;
  }
}

func_1987() {
  self.var_B8AE = undefined;
}

func_19A3(var_0) {
  self._blackboard.var_E1AB = var_0;
}

func_1995(var_0) {
  self._blackboard.var_E1AB = var_0;
  self._blackboard.var_38DC = var_0;
  var_1 = undefined;

  if(var_0 == "up") {
    var_1 = _func_2EE(self.asmname, "cannon_state", "up", 0);
  } else {
    var_1 = _func_2EE(self.asmname, "cannon_state", "down", 0);
  }

  self give_left_powers("cannon", var_1.anims, 1.0, 0.0, 1.0);
  self _meth_82B0(var_1.anims, 1.0);
}

func_DBDC(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = scripts\engine\utility::ter_op(isDefined(var_3), var_3, 30000);
  var_9 = distance(level.var_D127.origin, var_0);

  if(var_9 > var_8) {
    return;
  }
  if(isDefined(level.var_58DB)) {
    return;
  }
  level.var_58DB = 1;
  var_10["r_mbenable"] = getdvar("r_mbenable");
  var_10["r_mbRadialOverridePosition"] = getdvar("r_mbRadialOverridePosition");
  var_10["r_mbRadialOverridePositionActive"] = getdvarint("r_mbRadialOverridePositionActive");
  var_10["r_mbradialoverridestrength"] = getdvarfloat("r_mbradialoverridestrength");
  var_10["r_mbradialoverrideradius"] = getdvarfloat("r_mbradialoverrideradius");
  _setsaveddvar("r_mbenable", 1);
  _setsaveddvar("r_mbRadialOverridePosition", var_0);
  _setsaveddvar("r_mbRadialOverridePositionActive", 1);
  var_11 = scripts\engine\utility::ter_op(isDefined(var_2), var_2, 2000);
  var_1 = scripts\engine\utility::ter_op(isDefined(var_1), var_1, 0.135848);
  var_12 = var_1 / 4;
  var_4 = scripts\engine\utility::ter_op(isDefined(var_4), var_4, -0.107266);
  var_5 = scripts\engine\utility::ter_op(isDefined(var_5), var_5, 0.05);
  var_6 = scripts\engine\utility::ter_op(isDefined(var_6), var_6, 0.5);
  var_9 = distance(level.player.origin, var_0);
  var_13 = scripts\sp\math::func_C097(var_8, var_11, var_9);
  var_14 = scripts\sp\math::func_6A8E(var_1, var_12, var_13);
  var_14 = clamp(var_14, 0, 1);

  if(!isDefined(var_7)) {
    if(!scripts\engine\trace::ray_trace_passed(var_0 + (0, 0, 12), level.player getEye())) {
      var_14 = var_14 * 0.5;
      var_14 = clamp(var_14, 0, 1);
    }
  }

  _setsaveddvar("r_mbradialoverridestrength", var_14);
  _setsaveddvar("r_mbradialoverrideradius", var_4);
  wait(var_5);
  thread scripts\sp\utility::func_AB9A("r_mbradialoverridestrength", var_10["r_mbradialoverridestrength"], var_6);
  thread scripts\sp\utility::func_AB9A("r_mbradialoverrideradius", var_10["r_mbradialoverrideradius"], var_6);
  scripts\engine\utility::flag_wait_or_timeout("frag_force_delete", var_6);
  _setsaveddvar("r_mbenable", var_10["r_mbenable"]);
  _setsaveddvar("r_mbRadialOverridePosition", var_10["r_mbRadialOverridePosition"]);
  _setsaveddvar("r_mbRadialOverridePositionActive", var_10["r_mbRadialOverridePositionActive"]);
  level.var_58DB = undefined;
}

func_D527(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawn("script_origin", var_1);
  var_5 playSound(var_0, "sounddone");

  if(isDefined(var_2)) {
    var_5 _meth_8277(var_2, 0);
  }

  if(isDefined(var_3)) {
    var_5 ghostattack(var_3, 0);
  }

  if(isDefined(var_4)) {
    var_5 linkto(var_4);
  }

  var_5 waittill("sounddone");
  var_5 delete();
}

func_D52C(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = scripts\engine\utility::spawn_tag_origin(self.origin, self.angles);

  if(!isDefined(var_1)) {
    var_1 = _getpartname(self.model, 0);
  }

  var_6 linkto(self, var_1, (0, 0, 0), (0, 0, 0));
  var_6 playSound(var_0, "sounddone");

  if(isDefined(var_2)) {
    var_6 _meth_8277(var_2, 0);
  }

  if(isDefined(var_3)) {
    var_6 ghostattack(var_3, 0);
  }

  if(isDefined(var_4)) {
    func_D52D(var_6, "sounddone", var_4);
  } else {
    var_6 waittill("sounddone");
  }

  if(isDefined(var_5)) {
    wait(var_5);
  }

  var_6 ghostattack(0, 0.1);
  var_6 delete();
}

func_D52D(var_0, var_1, var_2) {
  var_0 endon(var_1);
  self waittill(var_2);
  return;
}

func_F2FF() {
  self _meth_84BF(1);
  level.var_A056.var_D824 = scripts\engine\utility::array_add(level.var_A056.var_D824, self);
  thread func_413C();
  level.player _meth_84D4(1);
}

func_413B() {
  if(isDefined(self)) {
    self _meth_84BF(0);
    level.var_A056.var_D824 = scripts\engine\utility::array_remove(level.var_A056.var_D824, self);
  }

  level.var_A056.var_D824 = scripts\engine\utility::array_removeundefined(level.var_A056.var_D824);

  if(level.var_A056.var_D824.size == 0) {
    level.player _meth_84D4(0);
  }
}

func_413C() {
  self waittill("entitydeleted ");
  func_413B();
}

func_A287(var_0) {
  if(isDefined(var_0)) {
    if(isDefined(level.script) && level.script == "moonjackal") {
      level.player scripts\engine\utility::delaycall(1, ::_meth_82C0, "jackal_mute_engines", 1);
    } else {
      level.player _meth_82C0("jackal_mute_engines", var_0);
    }
  } else
    level.player _meth_82C0("jackal_mute_engines", 0.5);
}

func_A388(var_0) {
  if(isDefined(var_0)) {
    if(isDefined(level.script) && level.script == "moonjackal") {
      level.player scripts\engine\utility::delaycall(2, ::_meth_82C0, "jackal_cockpit", 0.5);
    } else {
      level.player _meth_82C0("jackal_cockpit", var_0);
    }
  } else
    level.player _meth_82C0("jackal_cockpit", 0.5);
}

func_1990(var_0) {
  self._blackboard.var_C97C = var_0;
}

func_198E(var_0) {
  self._blackboard.var_0039 = var_0;
}

func_19A1() {
  self.bt.var_EF78 = 1;
}

func_198B(var_0) {
  self.var_38A2 = 0;
  thread func_198C(var_0);
}

func_198C(var_0) {
  self notify("cooldown_events_think");
  self endon("cooldown_events_think");
  self endon("death");
  wait(var_0);
  self.var_38A2 = 1;
}

func_3819() {
  if(!self.var_38A2) {
    return 0;
  }

  if(self.ignoreme) {
    return 0;
  }

  if(func_9CB2()) {
    return 0;
  }

  if(func_9B67()) {
    return 0;
  }

  return 1;
}

func_9BCF() {
  if(isDefined(self._blackboard) && isDefined(self._blackboard.var_A421)) {
    return 1;
  }

  if(isDefined(self.var_A420) && self.var_A420.size > 0) {
    return 1;
  }

  return 0;
}

func_9CB2() {
  if(isDefined(self._blackboard) && self._blackboard.var_EF72) {
    return 1;
  } else {
    return 0;
  }
}

func_9B67() {
  if(isDefined(self._blackboard) && self._blackboard.animscriptedactive) {
    return 1;
  } else {
    return 0;
  }
}

func_9C06() {
  if(isDefined(self._blackboard) && isDefined(self._blackboard.var_90EE)) {
    return 1;
  } else {
    return 0;
  }
}

func_16EE(var_0, var_1) {
  var_2 = level.var_90E2.var_5084.size;
  level.var_90E2.var_5084[var_2] = var_0;
  level.var_90E2.var_508A[var_2] = var_1;
}

func_A224(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  if(var_0) {
    setomnvar("ui_jackal_autopilot", 1);

    if(var_1) {
      func_A112("jackal_hud_autopilot");
    }
  } else
    setomnvar("ui_jackal_autopilot", 0);
}

func_9641() {
  level.var_A056.trigger_func = spawnStruct();
  level.var_A056.trigger_func.var_A0E5 = ::func_A0E5;
  level.var_A056.trigger_func.var_A0E2 = ::func_A0E2;
  level.var_A056.trigger_func.var_A0E3 = ::func_A0E3;
  level.var_A056.trigger_func.var_A0E1 = ::func_A0E1;
}

func_A0E1(var_0, var_1, var_2, var_3) {
  scripts\engine\utility::flag_set(var_3);
  level.var_D127 endon("death");
  level notify("jackal_autoturn");
  level endon("jackal_autoturn");
  func_A1DD("fly");
  func_A1DC(400);
  func_A14A();
  func_A155();
  var_4 = -1;
  func_D165(self.origin, 0, 1, 0);
  func_D16C(self.origin, 0, 1, 0, 1);
  _setsaveddvar("spaceshipautolevel", 2);
  func_A224();
  var_5 = 0;
  wait 0.05;
  var_6 = 150;
  var_7 = 450;
  var_8 = 150;
  var_9 = 0.9;
  func_D165(self.origin, 1, 0, 0.5);
  func_D16C(self.origin, 0.05, 1, 1, 1);
  func_A302(5.5, 0.5, "boundary_autoturn");

  while(scripts\engine\utility::flag(var_2) || var_4 < 0.6) {
    if(!isDefined(level.var_D127)) {
      break;
    }
    var_10 = anglesToForward(level.var_D127.angles);
    var_11 = vectornormalize(self.origin - level.var_D127.origin);
    var_4 = vectordot(var_10, var_11);
    var_12 = length(level.var_D127.spaceship_vel);
    var_13 = scripts\sp\math::func_C097(-1, 1, var_4);
    var_14 = scripts\sp\math::func_6A8E(var_6, var_7, var_13);
    var_15 = var_14 - var_12;
    var_16 = scripts\sp\math::func_C097(-1 * var_8, var_8, var_15);
    var_17 = scripts\sp\math::func_6A8E(1 - var_9, 1 + var_9, var_16);
    func_A301(var_17, 0.05, "boundary_autoturn");

    if(var_4 > 0.4 && !var_5) {
      _setsaveddvar("spaceshipautolevel", 0);
      var_5 = 1;
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
  scripts\engine\utility::flag_clear(var_3);
}

func_A0E5(var_0) {
  if(var_0 && !self.var_138F0) {
    setomnvar("ui_jackal_boundary_warning", 1);
    self.script_team = "allies";
    func_105DB("capitalship", undefined, "none", "none", 0);
    thread func_A0E6();
    thread func_A0E9();
    self.var_138F0 = 1;
  } else if(!var_0 && self.var_138F0) {
    setomnvar("ui_jackal_boundary_warning", 0);
    level notify("stop_boundary_warning_alarm");
    func_0B76::func_F42C("none");
    func_105DA();
    self.var_138F0 = 0;
  }
}

func_A0E2() {
  self endon("stop_trigger_push");

  for(;;) {
    func_A14E(1);

    if(!scripts\engine\utility::player_is_in_jackal() || level.player scripts\sp\utility::func_65DB("disable_jackal_map_boundary_push")) {
      func_A078((0, 0, 0), 0.05, "boundary_push" + self.var_12751);
      wait 0.05;
      continue;
    }

    var_0 = vectornormalize(self.var_98F5.origin - self.var_C75B.origin);
    var_1 = vectornormalize(self.var_C75B.origin - self.var_98F5.origin);
    var_2 = vectornormalize(level.var_D127.origin - self.var_98F5.origin);
    var_3 = vectornormalize(level.var_D127.origin - self.var_C75B.origin);
    var_4 = vectordot(var_2, var_1);
    var_5 = vectordot(var_3, var_0);
    var_4 = clamp(var_4, 0, 1);
    var_5 = clamp(var_5, 0, 1);
    var_6 = 1 - scripts\sp\math::func_C097(0, var_4 + var_5, var_5);
    var_7 = scripts\sp\math::func_6A8E(0, self.var_EEBF, var_6);
    var_7 = var_7 * var_0;
    func_A078(var_7, 0.05, "boundary_push" + self.var_12751);
    wait 0.05;
  }
}

func_A0E3() {
  func_A14E(0);

  if(!scripts\engine\utility::player_is_in_jackal()) {
    return;
  }
  func_A078((0, 0, 0), 0.05, "boundary_push" + self.var_12751);
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
  var_0 = spawn("script_origin", level.var_D127.origin);
  var_0 playSound("jackal_boundary_warning", "sounddone");
  var_0 func_A0E8();
  var_0 stopsounds();
  wait 0.05;
  var_0 delete();
}

func_A0E8() {
  level endon("stop_boundary_warning_alarm");
  self waittill("sounddone");
}

func_1997() {
  func_19B1(0);
  func_19AF(100, 100, 100);
  self.var_6E9C.var_50D1 = 0.1;
  self.var_6E9C.var_50D0 = 0.2;
  self.ignoreme = 1;
  self.maxhealth = int(self.maxhealth * 1.5);
  self.health = self.maxhealth;
}

func_1999() {
  func_19B1(0);
  func_19AF(100, 100, 100);
  self.var_6E9C.var_50D1 = 0.4;
  self.var_6E9C.var_50D0 = 0.5;
  self.ignoreme = 1;
  self.maxhealth = int(self.maxhealth * 1.5);
  self.health = self.maxhealth;
}

func_A064(var_0) {
  var_1 = 0;

  for(;;) {
    var_2 = tablelookupbyrow("sp\mostwanted.csv", var_1, 10);

    if(!isDefined(var_2) || var_2 == "") {
      break;
    }
    if(var_2 == var_0) {
      var_3 = tablelookupbyrow("sp\mostwanted.csv", var_1, 2);
      return var_3;
    }

    var_1++;
  }

  return undefined;
}

func_A063() {
  self waittill("death");
  func_0A2F::func_DA45(self.var_92BD);
}

func_1998() {
  func_19AF(100, 100, 100);
  self.var_6E9C.var_50D1 = 0.4;
  self.var_6E9C.var_50D0 = 0.5;
  self.var_51E6 = 1;
}

func_136A6(var_0) {
  self endon("death");

  for(;;) {
    self waittill("trigger", var_1);

    if(!isDefined(var_0) || var_1 != var_0) {
      continue;
    }
    break;
  }
}

func_116A8(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  var_3 = scripts\sp\hud_util::func_48B7("black", 0, level.player);
  var_4 = scripts\sp\hud_util::createfontstring("default", 1.5);
  var_4.location = 0;
  var_4.alignx = "left";
  var_4.aligny = "top";
  var_4.foreground = 1;
  var_4.sort = 20;
  var_4.alpha = 0;
  var_5 = 0.3;
  var_4 fadeovertime(var_5);
  var_3 fadeovertime(var_5);
  var_3.alpha = 0.7;
  var_4.alpha = 1;
  var_4.x = 40;
  var_4.y = 200 + var_2;
  var_4.label = " " + var_0;
  var_4.color = (1, 1, 1);
  wait(var_1);
  var_5 = 0.5;
  var_4 fadeovertime(var_5);
  var_3 fadeovertime(var_5);
  var_3.alpha = 0.0;
  var_4.alpha = 0;
  wait(var_5);
  var_4 destroy();
  var_3 destroy();
}