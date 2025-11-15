/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: SP\2911.gsc
************************/

func_96D7() {
  func_965A();
  precacheshellshock("default_nosound");
  precachesuit("normal_sp");
  precachemodel("vm_hero_protagonist_helmet");
  precachemodel("hero_jackal_helmet_a");
  func_F5FF();
  scripts\sp\thermal::func_977D();
  scripts\sp\gameskill::func_95F9();
  scripts\sp\gameskill::func_D3A6();
  scripts\sp\footsteps::func_4FF0();
  lib_0B60::func_96DC();
  scripts\sp\slowmo_init::func_1032A();
  setsaveddvar("cg_useplayerbreathsys", 1);
  foreach(var_01 in level.players) {
    var_01.maxhealth = level.player.health;
    var_01.var_9B34 = 0;
    var_01 func_16BC(::func_FE41);
    var_01 thread scripts\sp\gameskill::playerhealthregen();
    var_01 thread func_D37B();
    level.player thread lib_0B2A::func_B9D3();
    lib_0E42::init();
  }

  if(!level.console) {
    level.player scripts\sp\utility::func_65E0("script_allow_showviewmodel");
    if(!is_jackal_only_mission()) {
      thread handle_fov_viewmodel();
    }
  }
}

func_F5FF() {
  level.player setsuit("normal_sp");
  switch (level.script) {
    case "shipcrib_moon":
    case "phstreets":
    case "phparade":
    case "shipcrib_epilogue":
    case "shipcrib_prisoner":
    case "shipcrib_rogue":
    case "shipcrib_titan":
    case "shipcrib_europa":
      setsaveddvar("spaceshipPilotModel", "viewmodel_base_animated");
      level.player _meth_8573("nopack_nohelmet_shadow");
      level.player _meth_84C7("currentViewModel", "viewmodel_base_viewhands_iw7_naval");
      level.player givegoproattachments("viewmodel_base_viewhands_iw7_naval");
      level.player _meth_8574("body_hero_protagonist_vm_legs_naval");
      break;

    case "phspace":
      setsaveddvar("spaceshipPilotModel", "viewmodel_base_animated_naval");
      level.player _meth_8573("default_character_shadow");
      level.player _meth_84C7("currentViewModel", "viewmodel_base_viewhands_iw7_naval");
      level.player givegoproattachments("viewmodel_base_viewhands_iw7_naval");
      level.player _meth_8574("body_hero_protagonist_vm_legs_naval");
      break;

    case "titanjackal":
    case "titan":
      setsaveddvar("spaceshipPilotModel", "viewmodel_base_animated_desert");
      level.player _meth_8573("default_character_shadow");
      level.player _meth_84C7("currentViewModel", "viewmodel_base_viewhands_iw7_desert");
      level.player givegoproattachments("viewmodel_base_viewhands_iw7_desert");
      level.player _meth_8574("body_hero_protagonist_vm_legs_desert");
      break;

    case "sa_assassination":
      setsaveddvar("spaceshipPilotModel", "viewmodel_body_mp_stryker_2");
      level.player _meth_8573("default_character_shadow");
      level.player _meth_84C7("currentViewModel", "viewmodel_base_viewhands_iw7");
      level.player givegoproattachments("viewmodel_base_viewhands_iw7");
      level.player _meth_8574("body_hero_protagonist_vm_legs");
      break;

    default:
      setsaveddvar("spaceshipPilotModel", "viewmodel_base_animated");
      level.player _meth_8573("default_character_shadow");
      level.player _meth_84C7("currentViewModel", "viewmodel_base_viewhands_iw7");
      level.player givegoproattachments("viewmodel_base_viewhands_iw7");
      level.player _meth_8574("body_hero_protagonist_vm_legs");
      break;
  }
}

func_FE41() {
  self waittill("death");
  if(isDefined(self.var_10956)) {
    return;
  }

  if(getdvar("r_texturebits") == "16") {
    return;
  }

  self shellshock("default_nosound", 3);
}

func_D37B() {
  for(;;) {
    self waittill("damage", var_00, var_01, var_02, var_03, var_04, var_03, var_03, var_03, var_03, var_05);
    if(isDefined(self.var_10954)) {
      continue;
    }

    if(scripts\engine\utility::getdamagetype(var_04) != "bullet") {
      var_06 = -32 * var_02 + self.origin;
    }

    if(isDefined(var_05) && getweaponbasename(var_05) == "iw7_sonic") {
      func_20B3();
    }
  }
}

func_20B3() {
  self shellshock("deafened", 2.5);
}

func_965A() {
  if(!scripts\engine\utility::add_init_script("level_players", ::func_965A)) {
    return;
  }

  level.var_B8D0 = 0;
  scripts\engine\utility::flag_init("missionfailed");
  level.players = getEntArray("player", "classname");
  for(var_00 = 0; var_00 < level.players.size; var_00++) {
    level.players[var_00].unique_id = "player" + var_00;
  }

  level.player = level.players[0];
  level.var_5012 = 190;
  setsaveddvar("g_speed", level.var_5012);
  thread func_CFF8();
}

func_D023() {
  for(;;) {
    var_00 = getdvarint("player_died_recently", 0);
    if(var_00 > 0) {
      var_00 = var_00 - 5;
      setdvar("player_died_recently", var_00);
    }

    wait(5);
  }
}

func_CFF8() {
  setdvar("player_died_recently", "0");
  thread func_D023();
  level scripts\sp\utility::func_178D(::scripts\engine\utility::flag_wait, "missionfailed");
  level.player scripts\sp\utility::func_178D(::scripts\sp\utility::func_137AA, "death");
  scripts\sp\utility::func_57D6();
  var_00 = [];
  var_00[0] = 70;
  var_00[1] = 30;
  var_00[2] = 0;
  var_00[3] = 0;
  setdvar("player_died_recently", var_00[level.var_7683]);
}

func_16BC(param_00) {
  if(!isDefined(self.var_4E0E)) {
    self.var_4E0E = [];
    thread func_4E0E();
  }

  self.var_4E0E = param_00;
}

func_4E0E() {
  foreach(var_01 in self.var_4E0E) {
    thread[[var_01]]();
  }
}

func_51E7() {}

handle_fov_viewmodel() {
  level.player endon("death");
  level.player scripts\sp\utility::func_65E0("fov_vm_hide");
  if(!levelrequiresfovhandling()) {
    return;
  }

  var_00 = 1.4;
  level.player scripts\sp\utility::func_65E1("script_allow_showviewmodel");
  for(;;) {
    if(!level.player scripts\sp\utility::func_65DB("script_allow_showviewmodel")) {
      level.player _meth_818A();
      level.player scripts\sp\utility::func_65E1("fov_vm_hide");
      level.player scripts\sp\utility::func_65E3("script_allow_showviewmodel");
    }

    var_01 = getdvarfloat("com_fovUserScale");
    if(var_01 >= var_00 && level.player getcurrentweapon() == "iw7_gunless") {
      if(!level.player scripts\sp\utility::func_65DB("fov_vm_hide")) {
        level.player _meth_818A();
        level.player scripts\sp\utility::func_65E1("fov_vm_hide");
      }
    } else if(level.player scripts\sp\utility::func_65DB("fov_vm_hide")) {
      level.player giveperkoffhand();
      level.player scripts\sp\utility::func_65DD("fov_vm_hide");
    }

    wait(0.05);
  }
}

is_jackal_only_mission() {
  return level.script == "phspace" || level.script == "moonjackal" || issubstr(level.script, "ja_");
}

levelrequiresfovhandling() {
  return level.script == "yard" || level.script == "prisoner" || level.script == "marsbase" || level.script == "marscrash" || level.script == "heist" || level.script == "phparade" || level.script == "moon_port" || issubstr(level.script, "shipcrib");
}